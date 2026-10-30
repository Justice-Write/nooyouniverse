# Noo YouNiverse mobile observation-log roadmap

Updated 2026-10-30. Current authority: `status-handoff.md` and `RELEASE-2026-10-29.md`.

This roadmap covers the private, local-first observation notebook and the public-site PWA. It does not turn observations into clinical measurements, approve health claims, or make the app a store product.

## Current release state

| Evidence state | Result |
|---|---|
| Source | Runtime commit `40b2b8f`; production `main` includes it at `73035f0` |
| Automated verification | 31/31 tests, browser smoke, 30-file distribution boundary and zero npm vulnerabilities pass |
| Android build | Debug/release builds pass; release lint 0 errors / 13 warnings |
| Unsigned candidate | 0.2.3/code 5 SHA-256 `d563271f26886ed47be7ed42b963c1eb90873a11c4eed48ecd4155b1bd881103` |
| Signed candidate | SHA-256 `8a9c7fc1d32ec60771fbfa057ceb6d9bc92e88d2a46b7bb4c1ebb9410d419e27`; v2/v3 signed; aligned; 39/39 assets; zero requested permissions |
| Distribution | GitHub test prerelease `v0.2.3-candidate-20261029`; ZIP SHA-256 `f46b99ebe616c7011a4640e4d7a8a4fd3d47ffaac4270903a0af33e8d5f74883` |
| Installation | Exact signed APK installed on the Android 13 owner test phone and pulled back byte-identical |
| Existing debug app | 0.2.2-debug/code 4 remains separate and unchanged; no data migration |
| Desktop PWA | Public PWA live and browser-usable; no installed Noo desktop shortcut found |
| Store/iOS | No store submission; no private-notebook iOS build or distribution path |

Build, signing, packaging, publication, installation and hands-on acceptance are separate states. Installation is complete; full device acceptance is not.

## Implemented product boundary

- Approved Mission 01–11 catalog extracted from the public Mission Log.
- Context, uncertainty and free-text observations; observations are never labeled measurements.
- History, search and mission/outcome filters.
- Edits retain append-only correction history.
- Delete-one and wipe-all local controls.
- Versioned `noo-private-observation-log` v1 export/import with mission and clinical-field validation.
- Deterministic imported correction timestamps.
- Local persistence and unreadable-store recovery.
- Separate 21+ / educational acknowledgment.
- Android cloud-backup and device-transfer exclusions for private data.
- Public-site offline snapshot, check hub and three Android launcher entries.
- Empty first run; all shipped fixtures are synthetic.
- No accounts, remote sync, sensors, diagnosis, dosing or prescription behavior.

## Data preservation rules

The release package and debug package have separate app-private WebView stores. No automatic migration exists. Never uninstall, clear data or replace a signer to make an update succeed. Compare device, package, signer, version and artifact hash first. Exported JSON contains personal free text and correction history; it is not encrypted and belongs only in an owner-chosen private location.

The public-site PWA and private notebook are different products. Installing the PWA does not install or migrate the notebook.

## Remaining acceptance work

1. Obtain exclusive phone access without interrupting another app workflow.
2. Verify each of the three launcher entries from a cold start and while the activity is already running.
3. Create synthetic data only, export it through the native picker, import it, restart/force-stop, and verify persistence/corrections.
4. Run TalkBack/large-text/keyboard-target and core touch-flow checks; record device screenshots that contain no personal notes.
5. Verify long-session/background/resume behavior.
6. Install and test the public PWA on desktop separately if desired; verify offline behavior and uninstallability without implying notebook installation.

Do not read or copy existing owner notes to perform these checks. Preserve both installed packages and their timestamps/data.

## Product and release gates

| Track | Current gate |
|---|---|
| Mission 11 / health language | Owner disposition plus named, signed, hash-bound human review |
| Missions 12–15 | Editorial/source/health/privacy/legal/accessibility approvals; remain absent from release |
| Google Play | Current account eligibility, privacy/legal review, reviewer journey, store signing and explicit submission authority |
| iOS private notebook | Mac/Xcode/signing design and explicit project authorization; not implemented |
| Remote sync/auth | Signed review packet, privacy/security architecture and explicit authorization before implementation |
| Community/newsletter/commerce | Separate products and data/operations reviews; not notebook scope |
| Edge redirects | Provider change and staged live verification; not mobile code |
| WebView hardening | Before the next version, test stricter file/content-origin settings, reject unrecognized navigation schemes and scope the JavaScript bridge without breaking JSON import/offline assets |

## Repeatable verification

From `mobile/`:

```text
npm ci
npm test
npm run smoke
npm run verify-distribution
npm audit --audit-level=high
```

Then use the committed Gradle wrapper for clean debug/release builds and release lint. Inspect package/version/label, zero permissions, launcher aliases/task affinities, backup rules, alignment, signature certificate and exact 39-file asset parity. For production website bytes, run `python mobile/scripts/verify-live.py` from the repository root.

See `BUILD-ANDROID.md`, `DEVICE-INSTALL.md`, `PHONE-CHECKLIST.md`, `DESKTOP.md`, `DATA-BOUNDARIES.md`, `REVIEW-PACKET.md`, `STORE-LISTING-DRAFT.md` and `SYNC-BACKLOG.md`.
