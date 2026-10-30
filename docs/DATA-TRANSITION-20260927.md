> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Verified debug-to-release transition plan — 2026-09-27

**Do not install while the portfolio installation hold is active.** This is a future execution plan; no personal observations were read or migrated.

> **Superseding verification — 2026-10-23:** the signed 0.2.0 and 0.2.1 files
> in `mobile/dist/` are historical artifacts and must not be installed. They
> predate the release-identity fix; the signed 0.2.1 also predates explicit
> Android cloud/device-transfer exclusions for private observations. Current
> source includes both fixes. Fresh Gradle debug and unsigned-release builds,
> lint, 29/29 tests, browser smoke, 39/39 packaged-file parity, manifest checks
> and ZIP alignment passed from exact implementation commit
> `a757914428e6d4becf3abf8fc8f0056530a611ba`. The corrected unsigned release
> SHA-256 is
> `889f2df1d3e4a6192624215727a988776263ed250609f47e56a99086cf192e6b`;
> full evidence is in `ANDROID-BUILD-EVIDENCE-2026-10-24.md`.
> The repaired candidate is version 0.2.2 / code 4 so it cannot be confused
> with the rejected signed 0.2.1. It is not distributable: signing, post-sign verification and any device action
> remain owner-gated.

## Identity evidence

Installed: com.nooyouniverse.observationlog.debug, code 1, 0.1.0-debug, target 36. Read-only APK pull confirmed signer SHA-256 e522332903499b3e615e03f543358836a3c89360904b202ca3745af6f16b2deb.

Existing historical release: com.nooyouniverse.observationlog, code 2, 0.2.0; signer 1241938be1eea287e5797c8671640157082027a391b4dffb1168c7a4ccd0eb0f. The first signed source-built release used the same release ID/key, code 3, 0.2.1, target 36, but is now explicitly rejected for installation because of the identity/backup findings above. See mobile/BUILD-EVIDENCE-20260927.json for the dated build evidence, not current acceptance. The debug and release package IDs have separate Android data sandboxes. A matching version does not transfer data; a release install cannot upgrade the debug app.

## Tested preparation

- Read-only extraction of the installed debug engine; synthetic fixture imported into it, exported, then imported into current engine: identical observations. No device storage was accessed.
- Regression test confirms separate stores preserve corrections, repeat merge imports are idempotent and the original store remains intact.
- On 2026-09-27 both Gradle variants built from source and the then-current release was signed with the existing owner key. That signed output is no longer an accepted candidate. On 2026-10-23 fresh corrected debug and unsigned-release variants built cleanly; release/debug lint passed with no errors, and all 39 packaged web files matched source exactly. No key was used in the 2026-10-23 run.
- No Android runtime acceptance has been run: installation is held. Browser gate/save/reload/export/invalid-clinical-field rejection and hub smoke passed.

## After the portfolio gate is explicitly released

1. In the existing debug app export version-1 noo-private-observation-log JSON to an owner-controlled file. Keep two private copies; record counts and selected observations/correction counts. Do not send the backup to any service.
2. Recheck candidate hash, package, version 0.2.2/code 4, target and release certificate against the evidence. Keep the debug app installed and untouched.
3. Install the release side by side; acknowledge the 21+ / non-medical gate anew (acknowledgment is intentionally separate from observations).
4. Import the JSON using Merge. Compare entry IDs, counts, dates, context, uncertainty and correction history against the saved export. Export from release and compare parsed observations. Verify after relaunch/process death.
5. Keep the old debug app and backups until owner acceptance. Failure: stop, retain old app, correct the importer or candidate. No uninstall, downgrade, clear-data or signature bypass is a recovery step.

## Other completed work and residuals

Windows Python/Chrome discovery and smoke-server readiness were repaired. Puppeteer is now 25.16.0; after a clean lockfile install, `npm audit` reports zero vulnerabilities and the unit suite has 29 passing tests. Docker image evidence remains dated 2026-09-27: the actual container passed all 10 routing/header/privacy-path checks and the temporary loopback container was stopped after testing.

Named health/science approver, unsigned review packet, Missions 12–15 approval, production-account decisions and any remote sync remain gated. iOS signing/build requires Mac/Xcode and owner signing credentials. A fresh 2026-10-23 public readback verified 29/29 deployed files plus the Mission 01–11/PWA/security-header surface; it did not verify provider-account analytics settings, physical-device behavior or authorize redeployment.
