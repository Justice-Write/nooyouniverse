# Private observation log

On-device notes linked to **approved** Noo YouNiverse missions already in `public/log.html`.

This is a local prototype. It is not a released product, not a medical record, and not shipped by the Cloudflare Worker (only `public/` is served).

## Run

```bash
npm test
npm run smoke
npm run serve
```

Open `http://127.0.0.1:4173`. First launch asks for a 21+ / not-medical acknowledgment. The log itself starts with **zero** observations. JSON under `tests/fixtures/` is synthetic test data only.

iPhone: only the **public-site** PWA is live, and physical installation remains
unverified. The private observation log has no iOS distribution path; a native build
would require a separately authorized Mac/Xcode/signing workflow
(`docs/IOS-HOME-SCREEN.md`).
Android source/build verification: `docs/BUILD-ANDROID.md`. Preview the check
hub and offline site copy locally through `npm run serve`. The exact signed
0.2.3/code 5 release candidate is installed and hash-verified on the Android 13
owner test phone. Full launcher/export/accessibility acceptance and physical
browser-PWA acceptance remain open (`docs/DEVICE-INSTALL.md`,
`docs/ANDROID-HOME-SCREEN.md`). Never uninstall or clear data to repeat a test.

## Rules baked into the store

- Mission IDs must exist in the extracted catalog (currently 01–11).
- Import rejects unknown missions and measurement/clinical keys (`heartRate`, `dose`, `diagnosis`, `sensorReadings`, …).
- Null results are valid.
- Uncertainty is a user label, not a computed scientific verdict.
- Edits keep prior versions. Wipe deletes on-device notes after confirm. Unreadable storage can be exported raw, then discarded.
