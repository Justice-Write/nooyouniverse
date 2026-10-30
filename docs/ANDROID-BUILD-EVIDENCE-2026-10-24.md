> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Android 0.2.2 exact-commit build evidence — 2026-10-24

Status: **LOCALLY VERIFIED UNSIGNED BUILD — NOT SIGNED — DO NOT INSTALL OR DISTRIBUTE**

## Subject

- Repository branch: `codex/noo-roadmap-20261023`
- Exact source commit:
  `a757914428e6d4becf3abf8fc8f0056530a611ba`
- Version: `0.2.2`, `versionCode 4`
- Release package: `com.nooyouniverse.observationlog`
- Build began and ended with a clean tracked worktree at the exact commit.
- The build outputs are ignored local files, not committed release artifacts.

## Pre-build application checks

- Clean `npm ci`: 25 packages installed; audit 0.
- `npm test`: **29/29 passed**.
- `npm run smoke`: passed. Chromium's automatic `/favicon.ico` request remained
  the known non-failing 404.
- `npm audit --audit-level=high`: 0 vulnerabilities.
- Installed smoke dependency: `puppeteer-core@25.16.0`.
- PowerShell signing-helper parse: passed.
- Git Bash emulator-helper syntax: passed.

## Gradle result

From `mobile/android`, a clean no-daemon run completed:

`clean :app:assembleDebug :app:assembleRelease :app:lintDebug :app:lintRelease`

Result: **BUILD SUCCESSFUL**, 93 actionable tasks (90 executed, 3 up to date).
The Windows build used a short local temporary path to avoid Unix-domain-socket
path-length failures. No signing key was used.

| Output | SHA-256 |
|---|---|
| `app/build/outputs/apk/debug/app-debug.apk` | `be7dc0bb3cc2ae104a85e79f99779ac489b0d64a363bc39cbbc1f0a100b95584` |
| `app/build/outputs/apk/release/app-release-unsigned.apk` | `889f2df1d3e4a6192624215727a988776263ed250609f47e56a99086cf192e6b` |

## Release APK inspection

- Package/version: `com.nooyouniverse.observationlog`, code 4, `0.2.2`.
- Compile SDK: 34; target SDK: 36.
- Application label: `Noo Check Hub`.
- Requested permissions: **0**.
- Launcher aliases: **3**; production task affinities: log, site and hub.
- `android:allowBackup=false`; packaged manifest references both legacy and
  modern backup-rule resources.
- Packaged legacy backup exclusions: **9**.
- Packaged modern exclusions: **18**, split across one `cloud-backup` and one
  `device-transfer` section.
- Debug and release packaged-asset parity: **39/39** each, no missing, extra or
  hash-mismatched asset.
- Release ZIP alignment: passed (`zipalign -c -p 4`).
- Release lint: 0 errors, 13 warnings. Debug lint: 0 errors, 22 warnings.
- `apksigner verify` returned `DOES NOT VERIFY` / missing signature metadata,
  confirming this exact release output is unsigned.

## Gates that remain closed

- The signed 0.2.0 and locally ignored signed 0.2.1 files remain blocked
  historical evidence.
- The exact unsigned release hash above is not authorization to sign. Signing
  requires a fresh owner statement naming that full hash.
- The signing helper must stage/re-hash the owner-authorized input before key
  use and must produce a new signed hash plus package, alignment, certificate,
  signature-scheme and asset-parity evidence.
- Signing is not installation or distribution authorization. The portfolio
  installation hold remains active until the owner separately names the exact
  signed hash and device/action.
- No signing, key use, install, uninstall, emulator run, PWA install, upload,
  store action, push, merge or deployment occurred in this evidence run.
