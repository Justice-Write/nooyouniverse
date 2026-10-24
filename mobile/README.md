# Private observation log

> **Installation hold — 2026-10-24:** historical APK/Drive install directions below are superseded. Do not sign, distribute, install, uninstall or clear an existing profile. See [the current source/user guide](../docs/VISITOR-AND-OPERATOR-GUIDE.md) and obtain exact artifact/device acceptance separately.

On-device notes linked to **approved** Noo YouNiverse missions already in `public/log.html`.

This is a debug prototype. It is not a released product, not a medical record, and not shipped by the Cloudflare Worker (only `public/` is served).

## Run

```bash
npm test
npm run smoke
npm run serve
```

Open `http://127.0.0.1:4173`. First launch asks for a 21+ / not-medical acknowledgment. The log itself starts with **zero** observations. JSON under `tests/fixtures/` is synthetic test data only.

iPhone: `docs/IOS-HOME-SCREEN.md` (home-screen PWA; this Linux checkout cannot sign an IPA).
Android: `docs/BUILD-ANDROID.md`. Check hub + offline site copy: open `hub.html` or sideload the APK (`docs/DEVICE-INSTALL.md`). Live site on the home screen: `docs/ANDROID-HOME-SCREEN.md`.

## Rules baked into the store

- Mission IDs must exist in the extracted catalog (currently 01–11).
- Import rejects unknown missions and measurement/clinical keys (`heartRate`, `dose`, `diagnosis`, `sensorReadings`, …).
- Null results are valid.
- Uncertainty is a user label, not a computed scientific verdict.
- Edits keep prior versions. Wipe deletes on-device notes after confirm. Unreadable storage can be exported raw, then discarded.
