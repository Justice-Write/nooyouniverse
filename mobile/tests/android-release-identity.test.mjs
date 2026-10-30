import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { test } from "node:test";
import { fileURLToPath } from "node:url";
import path from "node:path";

const mobileRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

async function read(relativePath) {
  return readFile(path.join(mobileRoot, relativePath), "utf8");
}

function occurrences(text, value) {
  return text.split(value).length - 1;
}

test("release Android resources use the release application identity", async () => {
  const [manifest, strings, shortcuts] = await Promise.all([
    read("android/app/src/main/AndroidManifest.xml"),
    read("android/app/src/main/res/values/strings.xml"),
    read("android/app/src/main/res/xml/shortcuts.xml"),
  ]);

  assert.match(strings, /<string name="app_name">Noo Check Hub<\/string>/);
  assert.doesNotMatch(strings, /\(debug\)/i);
  assert.equal(
    occurrences(shortcuts, 'android:targetPackage="com.nooyouniverse.observationlog"'),
    3,
  );
  assert.doesNotMatch(shortcuts, /observationlog\.debug/);
  assert.equal(occurrences(manifest, 'android:taskAffinity="${applicationId}.'), 3);
  assert.doesNotMatch(manifest, /android:taskAffinity="[^"]*\.debug/);
});

test("debug Android overlays preserve the debug application identity", async () => {
  const [strings, shortcuts] = await Promise.all([
    read("android/app/src/debug/res/values/strings.xml"),
    read("android/app/src/debug/res/xml/shortcuts.xml"),
  ]);

  assert.match(strings, /<string name="app_name">Noo Check Hub \(debug\)<\/string>/);
  assert.equal(
    occurrences(shortcuts, 'android:targetPackage="com.nooyouniverse.observationlog.debug"'),
    3,
  );
});

test("Android backup and device-transfer paths exclude private observation data", async () => {
  const [manifest, legacyRules, extractionRules] = await Promise.all([
    read("android/app/src/main/AndroidManifest.xml"),
    read("android/app/src/main/res/xml/backup_rules.xml"),
    read("android/app/src/main/res/xml/data_extraction_rules.xml"),
  ]);

  assert.match(manifest, /android:allowBackup="false"/);
  assert.match(manifest, /android:fullBackupContent="@xml\/backup_rules"/);
  assert.match(manifest, /android:dataExtractionRules="@xml\/data_extraction_rules"/);

  const domains = [
    "root",
    "file",
    "database",
    "sharedpref",
    "external",
    "device_root",
    "device_file",
    "device_database",
    "device_sharedpref",
  ];
  for (const domain of domains) {
    const rule = `<exclude domain="${domain}" path="." />`;
    assert.equal(occurrences(legacyRules, rule), 1, `${domain} legacy exclusion`);
    assert.equal(occurrences(extractionRules, rule), 2, `${domain} modern exclusions`);
  }
  assert.match(extractionRules, /<cloud-backup>/);
  assert.match(extractionRules, /<device-transfer>/);
});

test("release signing stages a uniquely named candidate and preserves historical APKs", async () => {
  const [script, buildConfig] = await Promise.all([
    read("scripts/sign-release.ps1"),
    read("android/app/build.gradle"),
  ]);

  assert.doesNotMatch(script, /dist\\noo-observation-log-0\.2\.1-release\.apk/);
  assert.match(script, /noo-observation-log-0\.2\.3-corrected-/);
  assert.match(buildConfig, /versionCode 5/);
  assert.match(buildConfig, /versionName "0\.2\.3"/);
  assert.match(script, /dist\\candidates/);
  assert.match(script, /Refusing to overwrite existing signed candidate/);
  assert.match(script, /\[ValidatePattern\('\^\[0-9A-Fa-f\]\{64\}\$'\)\]/);
  assert.match(script, /\[string\]\$ExpectedUnsignedSha256/);
  assert.match(script, /\.unsigned-/);
  assert.match(script, /\.working-/);
  assert.match(script, /Copy-Item -LiteralPath \$unsigned -Destination \$stagedUnsigned/);
  assert.match(script, /\$unsignedHash -ne \$expectedUnsignedHash/);
  assert.match(script, /owner-authorized expected hash/);
  assert.match(script, /Move-Item -LiteralPath \$working -Destination \$output/);
  assert.match(script, /Assert-CandidateIdentity \$stagedUnsigned 'Staged unsigned input'/);
  assert.match(script, /Assert-CandidateIdentity \$working 'Signed output'/);
  assert.match(script, /\$expectedPackage = 'com\.nooyouniverse\.observationlog'/);
  assert.match(script, /\$expectedVersionCode = '5'/);
  assert.match(script, /\$expectedVersionName = '0\.2\.3'/);
  assert.match(script, /\$zipalign -c -p 4 \$working/);
  assert.match(script, /--v2-signing-enabled true/);
  assert.match(script, /--v3-signing-enabled true/);
  assert.match(script, /--v4-signing-enabled false/);
  assert.match(script, /1241938be1eea287e5797c8671640157082027a391b4dffb1168c7a4ccd0eb0f/);
  assert.match(script, /certificate SHA-256 does not match/);
  assert.ok(
    script.indexOf("$unsignedHash -ne $expectedUnsignedHash") <
      script.indexOf("$env:NOO_SIGN_STORE"),
    "authorized hash check must happen before signing passwords are loaded",
  );
});

test("persistence probe is scoped to a proven, explicitly authorized emulator", async () => {
  const script = await read("scripts/emulator-persistence.sh");
  assert.match(script, /NOO_EMULATOR_PROBE_ACK/);
  assert.match(script, /AUTHORIZED_EMULATOR_ONLY/);
  assert.match(script, /NOO_EMULATOR_SERIAL/);
  assert.match(script, /NOO_EXPECTED_DEBUG_SHA256/);
  assert.match(script, /debug APK SHA-256 does not match the owner-authorized expected hash/);
  assert.match(script, /android\/app\/build\/outputs\/apk\/debug\/app-debug\.apk/);
  assert.doesNotMatch(script, /mobile\/dist\/noo-observation-log-debug\.apk/);
  assert.match(script, /\^emulator-/);
  assert.match(script, /adb -s "\$SERIAL"/);
  assert.match(script, /ro\.kernel\.qemu/);
  assert.match(script, /did not prove ro\.kernel\.qemu=1; no APK was installed/);
  assert.doesNotMatch(script, /^adb (?!-s )/m);
  assert.ok(
    script.indexOf("ro.kernel.qemu") < script.indexOf('adb_target install -r "$APK"'),
    "emulator proof must happen before APK installation",
  );
  assert.ok(
    script.indexOf('actual_debug_sha256') < script.indexOf('adb_target install -r "$APK"'),
    "authorized debug hash check must happen before APK installation",
  );
});
