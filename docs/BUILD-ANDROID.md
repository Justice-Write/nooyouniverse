> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Build the Android debug APK

This produces a **debug APK for local inspection or an explicitly authorized
emulator probe**: offline website copy, observation log, and a checklist of
live pages. It is not a Play Store artifact or current device-install
authorization. Do not upload it to any store from this recipe.

> **2026-10-23 execution boundary:** building and inspecting locally is allowed;
> installing, signing, distributing or uploading is not. The portfolio
> installation hold remains active. Both signed files in `mobile/dist/` are
> rejected historical artifacts. Current release acceptance requires a fresh
> source build and all checks listed below; the old repack is not sufficient.

The app uses a WebView over offline assets. It has no `INTERNET` permission and does not read sensors. Live `https://` taps open Chrome.

## Prerequisites

- JDK 17+ (this environment used 21)
- Android SDK with `platforms;android-34` and `build-tools;36.0.0` (the signing
  and verification helper deliberately uses 36.0.0)
- The mission catalog generated from this repo (`npm run prepare-web` in `mobile/`)

## Reproducible steps

```bash
# 1. Refresh the approved-mission catalog from public/log.html
cd mobile
npm test

# 2. Point Gradle at the SDK
#    Copy mobile/android/local.properties.example → local.properties
#    Set sdk.dir to the absolute SDK path.

# 3. The Gradle wrapper is committed. Assemble debug:
cd android
./gradlew :app:assembleDebug
```

The APK lands at:

`mobile/android/app/build/outputs/apk/debug/app-debug.apk`

After the owner explicitly lifts the hold for the exact reported debug hash,
an authorized tester must first read back the named target serial/model, verify
they match the authorization, and then scope installation to that serial:

```bash
AUTHORIZED_DEVICE_SERIAL='owner-authorized serial here'
AUTHORIZED_DEBUG_SHA256='owner-authorized 64-hex hash here'
APK='app/build/outputs/apk/debug/app-debug.apk'
test "$(sha256sum "$APK" | awk '{print tolower($1)}')" = "${AUTHORIZED_DEBUG_SHA256,,}"
test "$(adb -s "$AUTHORIZED_DEVICE_SERIAL" get-serialno | tr -d '\r')" = "$AUTHORIZED_DEVICE_SERIAL"
adb -s "$AUTHORIZED_DEVICE_SERIAL" shell getprop ro.product.model
adb -s "$AUTHORIZED_DEVICE_SERIAL" install -r "$APK"
```

## Signing and user data

Debug builds are signed with the local debug keystore. A different machine or
checkout than the one that produced an existing phone prototype will usually
have a **different signature**.

- Android will not upgrade over a differently signed package.
- **Preserve user data:** export JSON from the old install, keep the old install
  intact, and install the approved candidate side-by-side only when its package
  identity permits that. Do not uninstall to work around a signature mismatch.
- Existing owner phone-test prototypes and their data are not available to this repository checkout.

## If the SDK is missing

Install command-line tools, accept licenses, then:

```bash
sdkmanager "platform-tools" "platforms;android-34" "build-tools;36.0.0"
```

If this cloud environment cannot complete that install, use `cd mobile && npm run serve` and exercise the same UI in a browser. The persistence and export/import code is the same library.

## Historical repack without Gradle — not an accepted release path

Used for the 2026-09-26 build. It is retained for reproducibility only. The
resulting signed 0.2.0 artifact and the first signed 0.2.1 source build are now
blocked because their release resources retained debug identity values; 0.2.1
also predates explicit private-data backup/transfer exclusions. Do not run this
recipe to create an install candidate.

Historically, when `dl.google.com` (Android SDK, AGP, Google
Maven) is unreachable, Gradle cannot run, but the Java side of this app is tiny
and unchanged since the last Gradle build, so `mobile/scripts/repack-apk.sh`
rebuilds everything else:

1. `npm run prepare-web` refreshes `assets/www` and the offline site copy.
2. `aapt2 link` against `android-34/android.jar` rebuilds `AndroidManifest.xml`
   and `resources.arsc` from source with the requested `versionCode` /
   `versionName` / package id (`com.nooyouniverse.observationlog`, no
   `.debug` suffix, `android:debuggable="false"`).
3. `classes*.dex` are reused from `dist/noo-observation-log-debug.apk`
   (built at `95df7f2`, after the last change to `MainActivity.java` /
   `AndroidManifest.xml`). With `RELEASE=1` the script flips
   `BuildConfig.DEBUG` to `false` inside the dex — AGP stores it as
   `Boolean.parseBoolean("true")`, so the literal is rewritten in place and the
   dex checksum/SHA-1 recomputed. The debug `noo_debug_cmd` intent hooks are
   therefore inert in the release repack.
4. `zipalign -p 4`, then v2+v3 signing with uber-apk-signer.

Tools that do not need `dl.google.com`:

| Tool | Source |
|---|---|
| `aapt2`, `zipalign` (static linux x86_64) | github.com/lzhiyong/android-sdk-tools release `34.0.3` |
| `android-34/android.jar` | github.com/Sable/android-platforms |
| signer (`apksig` + zipalign wrapper) | github.com/patrickfav/uber-apk-signer `1.3.0` |

```bash
export AAPT2=…/aapt2 ZIPALIGN=…/zipalign ANDROID_JAR=…/android-34/android.jar SIGNER_JAR=…/uber-apk-signer.jar
RELEASE=1 VERSION_CODE=3 VERSION_NAME=0.3.0 \
KS=…/noo-release-2026.jks KS_ALIAS=noo-release KS_PASS=… \
mobile/scripts/repack-apk.sh mobile/dist/noo-observation-log-0.3.0-release.apk
```

The release identity and backup configuration now live in the manifest and
variant resources. Therefore current candidates must be real Gradle builds;
reusing a debug DEX/resources package is not accepted even when the Java source
is unchanged.

## Current release-candidate verification

Before any future signing request, build debug and release from current source,
then require all of the following: unit tests and browser smoke pass; debug and
release lint have zero errors; the merged release manifest uses
`com.nooyouniverse.observationlog`, production labels/task affinities, no
requested permissions and the explicit backup/data-extraction exclusions; all
39 packaged assets match source; the APK is ZIP-aligned. After signing, repeat
package/version/manifest, asset-parity, alignment, certificate and v2/v3
signature checks and publish the full SHA-256 before asking for device access.
The owner-gated `mobile/scripts/sign-release.ps1` requires that exact unsigned
SHA-256 as `-ExpectedUnsignedSha256`; it stages and re-hashes the byte stream
before reading signing material, then signs only the staged copy.

## Release keystore

`noo-release-2026.jks` (alias `noo-release`, RSA-4096, valid to 2056) lives
**outside git** at `Documents/GitHub/_ops/keystores/` next to its
`.keystore.properties`. Every future sideload/Play build must use this key or
Android refuses the upgrade. Back it up only in an encrypted, access-restricted
credential vault or offline backup, with its password stored separately. Never
place the key or `.keystore.properties` in the ordinary APK/phone-drop folder,
and never commit either; `.gitignore` blocks `*.jks` / `*.keystore`.
