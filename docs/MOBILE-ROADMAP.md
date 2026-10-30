> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Noo YouNiverse — mobile observation-log roadmap

**2026-10-23 reconciliation:** See [DATA-TRANSITION-20260927.md](DATA-TRANSITION-20260927.md) for the original transition plan plus the superseding identity, backup-boundary and fresh-build evidence. Portfolio installation hold remains active; no APK in `mobile/dist/` is approved for installation.

Updated: 2026-10-24 (corrected 0.2.2/code 4 exact-commit unsigned build verified; no signing/install/distribution) · Owner: Christian · Persona: Cillian / Noo YouNiverse
Companion to MyPersonas branch `codex/noo-source-parity-20261023` at
`aaf212fa59b20d6b5deea8b3bd3598eec4aa533a`, file
`nooyouniverse.com/SITE-ROADMAP.md` (unpushed; owner checkout and
`origin/main` are stale). Site Phase 3 is live; Package A remains unapproved.

This file tracks the **private local observation-log prototype**, not a store product. Public Mission 09 remains an unbuilt-product concept.

## Cursor-completable product work — finished

| Item | State |
|---|---|
| Approved-mission catalog from `public/log.html` (01–11) | ✅ |
| Context + uncertainty + observations, including Mission 06 `stayedComparable` | ✅ |
| History, search, mission/outcome filters | ✅ |
| Edit with append-only correction history | ✅ |
| Delete one entry + wipe all on-device notes | ✅ |
| Validated export/import | ✅ |
| Persistence across relaunch (web) | ✅ |
| Persistence after Android force-stop (emulator) | ✅ 2026-09-24 `emulator-persistence.sh` |
| 21+ / not-medical first-run acknowledgment | ✅ |
| Unreadable-store recovery | ✅ |
| Observations kept distinct from measurements | ✅ |
| Fixtures isolated from shipped UI | ✅ |
| Android backup/cloud/device-transfer exclusions for private observation data | ✅ source + manifest verified 2026-10-23 |
| Public-site PWA / iOS home-screen path | ✅ live files documented, ⛔ physical install held; private observation-log iOS delivery remains unimplemented (`docs/IOS-HOME-SCREEN.md`) |
| Owner sideload playbook | ✅ `docs/DEVICE-INSTALL.md` |
| Human review packet (unsigned) | ✅ `docs/REVIEW-PACKET.md` |
| Store listing drafts — not submitted | ✅ `docs/STORE-LISTING-DRAFT.md` |
| Remote sync explicitly gated, not built | ✅ `docs/SYNC-BACKLOG.md` |
| Public waitlist / Mission 09 unchanged | ✅ |
| Unit tests | ✅ `cd mobile && npm test` |
| Headless Chrome smoke | ✅ `npm run smoke` |
| Historical Android debug APK | ✅ retained for emulator/probe evidence only; not approved for the owner's device |
| Historical signed APKs 0.2.0 / 0.2.1 | ⛔ retained as evidence only; known release-identity defect, and 0.2.1 predates explicit backup/transfer exclusions. Do not install or distribute |
| Corrected 0.2.2 / code 4 unsigned build | ✅ exact implementation commit `a757914428e6d4becf3abf8fc8f0056530a611ba`; release SHA-256 `889f2df1d3e4a6192624215727a988776263ed250609f47e56a99086cf192e6b`; correct identity, zero requested permissions, private-data backup exclusions and 39/39 asset parity. Not signed or install-authorized |
| Gradle-free historical rebuild path | ⚠️ retained for reproducibility; a repack is not current acceptance and must not bypass the source-built identity/backup checks |
| Desktop preview + self-host mirror config | ✅ local preview/config documented; ⛔ PWA install and self-host publication remain unaccepted/on hold (`docs/DESKTOP.md`, `deploy/docker/`) |
| Check hub of every site/app to verify | ✅ `mobile/web/hub.html` |
| Offline snapshot of `public/` in the APK | ✅ `npm run bundle-site` |
| Live-site PWA files for Chrome Add to Home screen | ✅ live and reverified 2026-10-23: manifest + shortcuts + maskable icons + network-first SW + offline page; real-device install/update/offline acceptance remains open |
| Phone checklist | ✅ `docs/PHONE-CHECKLIST.md` |
| Three Android launcher entries from one APK (site + log + hub) | ✅ declared and packaged; physical-device runtime acceptance held |

## Recommendations — what was done vs still human

| Recommendation | Cursor action this pass | Still needs a human |
|---|---|---|
| Owner phone install + process death | Exact-commit unsigned build, offline site, frozen playbook + historical emulator probe | Owner-authorized signing and post-sign verification first; owner must separately authorize device work for the resulting signed hash |
| Live website as a browser app | PWA files are already live + `docs/ANDROID-HOME-SCREEN.md` | Physical-device acceptance after the portfolio installation hold is lifted |
| Privacy / legal / health review | Unsigned packet with data inventory and sign-off table | Named reviewers; Cursor did **not** sign |
| Auth / remote sync | Documented why it stays out; no server added | Packet sign-off first |
| No community / FHIR / sensors / dosing | Still not implemented | Do not approve those specs here |
| iOS IPA / TestFlight / store submit | Listing drafts only; no Xcode; **not submitted** | Store-account, legal/privacy, build/signing and owner-submit gates remain unverified |
| Merge / deploy | Merged to `main` 2026-09-26 (owner-authorized). Deploy: see evidence log | Confirm deploy if the evidence log still shows ⚠️ |
| Local phone prototypes | Not accessed | Export/import if you compare installs |

## Still blocked

- Physical owner device — no action while the portfolio installation hold is active; old Drive/APK copies are superseded
- Exact-commit unsigned 0.2.2 rebuild/hash, then release signing and post-sign verification — key use/distribution requires a fresh exact owner authorization
- Named health-claim approver — **master blocker**, overdue since 2026-09-04
- iOS IPA (needs a Mac); Android release keystore now exists (`_ops/keystores/`)
- Store upload (Google personal-account verification is only a dated prior note; current Google access and all Apple readiness are unverified; review packet unsigned)
- Missions 12–15: copy drafted, art finished (`docs/mission-art-12-15/`), zero approved; `cursor/caffeine-context-variable-af50` remains an unapproved draft branch

## Evidence log

| Check | Result | Notes |
|---|---|---|
| `cd mobile && npm test` | ✅ 2026-10-23 | 29/29 after a clean lockfile install on `codex/noo-roadmap-20261023`; includes release identity, backup boundary, exact-hash signing, emulator-target safety, correction-timestamp migration, PWA/install-hold copy and dependency regressions; generated assets remained clean |
| `cd mobile && npm run smoke` | ✅ 2026-10-23 | Browser UI smoke passed; the local browser's automatic `/favicon.ico` request remains a non-failing 404 |
| `cd mobile && npm audit --audit-level=high` | ✅ 2026-10-23 | 0 vulnerabilities; `puppeteer-core` 25.16.0 |
| Emulator force-stop persistence | ✅ 2026-09-24 | Seed count 1 → force-stop → dump still `noo-private-observation-log` observation |
| Historical Android debug APK | ⚠️ evidence only | `mobile/dist/noo-observation-log-debug.apk`; do not install on the owner's device |
| Historical signed releases | ⛔ rejected 2026-10-23 | 0.2.0 and signed 0.2.1 predate the release-identity fix; signed 0.2.1 also predates explicit backup/transfer exclusions. Keep for evidence only; do not install |
| Corrected unsigned 0.2.2 build | ✅ local unsigned evidence only | Exact commit `a757914428e6d4becf3abf8fc8f0056530a611ba`; clean debug/release builds; lint 0 errors (22 debug / 13 release warnings); release code 4, production package/label/task affinities, target 36, 0 permissions, backup exclusions, ZIP alignment and 39/39 assets. Debug SHA-256 `be7dc0bb3cc2ae104a85e79f99779ac489b0d64a363bc39cbbc1f0a100b95584`; unsigned release SHA-256 `889f2df1d3e4a6192624215727a988776263ed250609f47e56a99086cf192e6b`; see `ANDROID-BUILD-EVIDENCE-2026-10-24.md` |
| PWA on `main`, headless Chromium | ✅ 2026-09-26 | SW active on `/`, `/log`, `/sources`, `/corrections`; 14 shell entries cached; offline `/log` served from cache; offline unknown route → "Signal lost" page |
| `deploy/docker` nginx parity | ✅ config, ⚠️ image | `verify.sh` 10/10 against nginx running the shipped `nginx.conf`; `docker build` not run here (no daemon) |
| Cloudflare deploy of `main` | ✅ 2026-09-26 | Git build of 0478c13 succeeded; version 2917eaa8 at 100% traffic. Live: manifest 200 (3 shortcuts), SW active, offline page 200, `.deploy-poke` 404, CSP/nosniff/frame-deny present. CSP then widened for Cloudflare Web Analytics |
| Branch reconciliation | ✅ local, ⚠️ unpushed | 2026-10-23: isolated branch `codex/noo-roadmap-20261023` includes the Android release identity, backup exclusion and smoke-dependency fixes, starting from five local commits ahead of `origin/main`. Nothing pushed, signed, installed or distributed |
| Play / App Store submit | ❌ not done | Drafts only |
| Owner phone | ⛔ hold | Old APK/Drive directions are superseded. Do nothing until a fresh corrected signed hash is reported and the owner explicitly releases the hold for that exact artifact |
