# Scheduled Android transfer acceptance

Updated 2026-10-30. This is a test procedure, not completed native acceptance or permission to take the phone foreground.

## Prerequisites

The coordinator must grant an exclusive device slot; honor the current phone lease and human foreground ownership. Use a dedicated emulator/test profile with synthetic notes. Do not use, inspect, wipe or migrate the retained owner debug store. Check package, code, signer and APK hash against RELEASE-2026-10-29.md before testing. Canonical production lineage remains an owner decision: the existing release package was installed separately under broad installation authorization, not selected explicitly as a replacement for debug.

## Automated coverage

Run `cd mobile` then `npm run smoke`. An isolated headless browser creates a synthetic note, exports it, rejects malformed JSON, unsupported versions and clinical fields without altering records, reads a temporary JSON file through the real file-input/FileReader path, verifies selecting alone does not import, merges twice without duplicates, verifies Android bridge payload/retry through a stub, and reloads to check persisted observations. Temporary files are removed. The stub proves JavaScript handoff only, not Android picker completion, cancellation, provider write or file persistence.

## Exclusive native test sequence

1. Record device/OS, package/code, APK hash/signer, test profile and document-provider name in private evidence. Confirm the fixture store is empty. Create one clearly labeled SYNTHETIC TRANSFER note for Mission 07 with null outcome and high uncertainty. Edit it once; capture its exported observation ID and correction history as the baseline.
2. Choose Download JSON. In the Android create-document picker, choose a test-only local directory and unique filename. Save; read the file back through the provider. Verify parseable v1 export, one observation, expected ID/fields and complete correction history. Record file SHA-256. Do not treat a success toast as file readback.
3. Start another export and cancel. Compare observations to baseline; start export again and save to a second unique filename. Compare semantic observations, allowing export timestamps to differ.
4. Open import picker and cancel; confirm notes unchanged. Reopen picker and select the saved JSON. Before pressing Import, confirm the store is unchanged. Import in Merge mode twice; expect exactly one observation with the same ID and correction history.
5. On the isolated fixture store only, import malformed JSON, version 999, an unknown mission, and a clinical-field payload. For each, expect an error and byte/semantic-equivalent stored observations. Never perform these probes on personal notes.
6. Force-stop and relaunch only the scheduled test package. Verify the synthetic record and correction history persist; export again and compare observations against baseline.
7. Exercise hub, log and saved-site launcher entries in both cold and warm states; verify visible route after each. Do not infer acceptance from `am start` status alone. Record portrait/landscape and screen-reader/large-text results separately.
8. Stop if another app takes foreground or the lease changes. Record the interrupted step as unverified. Preserve test artifacts until reviewed; never uninstall/clear the owner's package for cleanup.

## Receipt fields

Date/time with timezone; exclusive slot; test device/profile; source/package/version/hash/signer; provider; each step PASS/FAIL/NOT RUN; exported file hashes and semantic comparison; record count and correction preservation; screenshots without personal data; remaining failures. Keep hardware identifiers and private paths out of public Git.

Current native result: NOT RUN under this procedure. Existing installation/hash evidence does not satisfy these steps. No automatic debug-to-release migration is implemented or authorized by this checklist.
