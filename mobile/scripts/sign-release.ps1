param(
    [Parameter(Mandatory=$true)][string]$KeystoreProperties,
    [Parameter(Mandatory=$true)]
    [ValidatePattern('^[0-9A-Fa-f]{64}$')]
    [string]$ExpectedUnsignedSha256,
    [string]$SdkRoot = "$env:LOCALAPPDATA\Android\Sdk"
)
$ErrorActionPreference = 'Stop'
$mobileRoot = Split-Path $PSScriptRoot -Parent
$expectedCertificateSha256 = '1241938be1eea287e5797c8671640157082027a391b4dffb1168c7a4ccd0eb0f'
$expectedPackage = 'com.nooyouniverse.observationlog'
$expectedVersionCode = '4'
$expectedVersionName = '0.2.2'
$buildTools = Join-Path $SdkRoot 'build-tools\36.0.0'
$aapt2 = Join-Path $buildTools 'aapt2.exe'
$zipalign = Join-Path $buildTools 'zipalign.exe'
$apksigner = Join-Path $buildTools 'apksigner.bat'
foreach ($tool in @($aapt2, $zipalign, $apksigner)) {
    if (-not (Test-Path -LiteralPath $tool)) { throw "Required Android build tool does not exist: $tool" }
}

function Assert-CandidateIdentity([string]$ApkPath, [string]$Stage) {
    $badgingOutput = & $aapt2 dump badging $ApkPath 2>&1
    if ($LASTEXITCODE -ne 0) { throw "$Stage APK badging inspection failed." }
    $badging = $badgingOutput -join "`n"
    $packagePattern = "package: name='$([regex]::Escape($expectedPackage))' versionCode='$([regex]::Escape($expectedVersionCode))' versionName='$([regex]::Escape($expectedVersionName))'"
    if ($badging -notmatch $packagePattern) {
        throw "$Stage APK is not the expected $expectedPackage version $expectedVersionName (code $expectedVersionCode)."
    }
}

$unsigned = Join-Path $mobileRoot 'android\app\build\outputs\apk\release\app-release-unsigned.apk'
if (-not (Test-Path -LiteralPath $unsigned)) { throw 'Unsigned release APK does not exist. Build and verify it first.' }
$candidateDirectory = Join-Path $mobileRoot 'dist\candidates'
New-Item -ItemType Directory -Force $candidateDirectory | Out-Null
$stagedUnsigned = Join-Path $candidateDirectory ('.unsigned-' + [guid]::NewGuid().ToString('N') + '.apk')
$working = Join-Path $candidateDirectory ('.working-' + [guid]::NewGuid().ToString('N') + '.apk')
$expectedUnsignedHash = $ExpectedUnsignedSha256.ToLowerInvariant()
$unsignedHash = ''
$output = ''
try {
    Copy-Item -LiteralPath $unsigned -Destination $stagedUnsigned
    $unsignedHash = (Get-FileHash -LiteralPath $stagedUnsigned -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($unsignedHash -ne $expectedUnsignedHash) {
        throw "Staged unsigned APK SHA-256 does not match the owner-authorized expected hash."
    }
    Assert-CandidateIdentity $stagedUnsigned 'Staged unsigned input'
    $output = Join-Path $candidateDirectory "noo-observation-log-0.2.2-corrected-$($unsignedHash.Substring(0,12))-signed.apk"
    if (Test-Path -LiteralPath $output) {
        throw "Refusing to overwrite existing signed candidate: $output"
    }

    # Read signing material only after the exact staged byte stream passes the
    # owner-authorized hash and identity checks.
    $propertiesPath = (Resolve-Path -LiteralPath $KeystoreProperties).Path
    $signing = @{}
    foreach ($line in [IO.File]::ReadAllLines($propertiesPath)) {
        if ($line -match '^\s*([^#!][^=]*)=(.*)$') { $signing[$matches[1].Trim()] = $matches[2].Trim() }
    }
    $keyFile = $signing.storeFile.Replace('\\', '\')
    if (-not [IO.Path]::IsPathRooted($keyFile)) { $keyFile = Join-Path (Split-Path $propertiesPath -Parent) $keyFile }
    if (-not (Test-Path -LiteralPath $keyFile)) { throw 'Signing key file does not exist.' }

    & $zipalign -p 4 $stagedUnsigned $working
    if ($LASTEXITCODE -ne 0) { throw 'APK alignment failed.' }
    $env:NOO_SIGN_STORE = $signing.storePassword
    $env:NOO_SIGN_KEY = $signing.keyPassword
    & $apksigner sign --v1-signing-enabled false --v2-signing-enabled true --v3-signing-enabled true --v4-signing-enabled false --ks $keyFile --ks-key-alias $signing.keyAlias --ks-pass env:NOO_SIGN_STORE --key-pass env:NOO_SIGN_KEY $working
    if ($LASTEXITCODE -ne 0) { throw 'APK signing failed.' }
    & $zipalign -c -p 4 $working
    if ($LASTEXITCODE -ne 0) { throw 'Signed APK alignment verification failed.' }
    Assert-CandidateIdentity $working 'Signed output'
    $verifyOutput = & $apksigner verify --verbose --print-certs $working 2>&1
    if ($LASTEXITCODE -ne 0) { throw 'APK signature verification failed.' }
    $verifyText = $verifyOutput -join "`n"
    if ($verifyText -notmatch 'Verified using v2 scheme \(APK Signature Scheme v2\): true' -or
        $verifyText -notmatch 'Verified using v3 scheme \(APK Signature Scheme v3\): true') {
        throw 'Expected APK Signature Scheme v2 and v3 verification did not both pass.'
    }
    $certificateMatch = [regex]::Match($verifyText, 'Signer #1 certificate SHA-256 digest:\s*([0-9a-fA-F]+)')
    if (-not $certificateMatch.Success -or
        $certificateMatch.Groups[1].Value.ToLowerInvariant() -ne $expectedCertificateSha256) {
        throw 'Signing certificate SHA-256 does not match the expected Noo release certificate.'
    }
    Move-Item -LiteralPath $working -Destination $output
    $verifyOutput | Write-Output
} finally {
    Remove-Item Env:NOO_SIGN_STORE,Env:NOO_SIGN_KEY -ErrorAction SilentlyContinue
    if (Test-Path -LiteralPath $stagedUnsigned) { Remove-Item -LiteralPath $stagedUnsigned -Force }
    if (Test-Path -LiteralPath $working) { Remove-Item -LiteralPath $working -Force }
}
Write-Output "Unsigned input SHA-256: $unsignedHash"
Get-FileHash -LiteralPath $output -Algorithm SHA256
# Deliberately no adb, installation, upload, or key generation.
