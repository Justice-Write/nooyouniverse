# Noo YouNiverse — status handoff

Updated: 2026-10-30 · Codex GPT-6. Public-safe release record.

## 0. Protocol — mandatory for every agent, every model, every task

1. **Read first.** Read this file top to bottom, then `AGENTS.md` (hard limits). Do not start from memory or from an older status doc.
2. **Before you start work**, add an entry to **§1 In progress** and save the file *before your first change*: UTC timestamp, who you are (tool + model), the task, the files/branches you expect to touch, and your plan in one or two lines. If you are interrupted, this entry is how the next agent knows what was half-done.
3. **When you finish (or stop)**, in the same sitting:
   - remove your §1 entry;
   - add a dated entry at the top of **§8 Work log**: what changed, evidence (commands run, test results, commit hashes, URLs checked), and what is left;
   - update **§3 Current state**, **§4 Blockers** and **§5 Next actions** if anything changed;
   - bump **Last updated** (date + who).
4. **Stale §1 entry from someone else?** They were interrupted. Check the files it lists (`git status`, mtimes, diffs), then finish or back out the work, and log what you found. Never delete it silently.
5. **Assume other agents are working right now.** Check `git status` and file mtimes before editing. Never overwrite a file another agent changed in the last hour; write a new file or append instead. If two §1 entries touch the same files, stop and resolve it here first.
6. **Only write what you verified.** Mark anything unverified as unverified. Absolute dates (YYYY-MM-DD), times in UTC. No "recently", no "soon".
7. **Commit this file with your work**, in the same commit. If you cannot commit or push (most agent sandboxes have no GitHub credentials), say so in your log entry and put the exact owner commands in §5.
8. **Keep it short.** §8 holds the last ~15 entries; move older ones to `docs/HANDOFF-ARCHIVE.md`. Current state beats history.
9. **Mirror.** The claude.ai Project "nooYouNiverse" holds a copy named `status-handoff.md`. If you can write Project docs, update the mirror whenever you update this file. **This repo file is canonical** if they differ.

Copy this protocol unchanged if you create a `status-handoff.md` for another project.

Signposts that point here: `CLAUDE.md` (Claude tools) and the banner at the top of `AGENTS.md` (Codex, Cursor, Copilot). If either disagrees with this file, this file wins — fix the signpost.

---

## 1. In progress

None. Off-phone transfer checks complete; native tests require an exclusive scheduled slot.

## 2. Project

Evidence-literacy educational website plus a separate local observation notebook. Observations are not medical measurements. No new health claims, held missions, remote sync, commerce or store submission are approved by this release.

## 3. Current state

- **Repository and website:** `origin/main` is `73035f0131992ff4068b4dd478e11c618b28dcf0` after merged PRs #6 and #7. Production public bytes are the PR #6 website payload; a fresh 2026-10-30 readback matched all 29/29 served files. Manifest, service worker and CSP/nosniff/frame-deny/referrer/permissions headers are present. HTTP still serves without redirect, `www` does not canonicalize to apex, and HSTS is absent.
- **Android package:** GitHub prerelease `v0.2.3-candidate-20261029` contains a three-file ZIP with digest `f46b99ebe616c7011a4640e4d7a8a4fd3d47ffaac4270903a0af33e8d5f74883`. Its APK is 0.2.3/code 5, package `com.nooyouniverse.observationlog`, SHA-256 `8a9c7fc1d32ec60771fbfa057ceb6d9bc92e88d2a46b7bb4c1ebb9410d419e27`, signer `1241938be1eea287e5797c8671640157082027a391b4dffb1168c7a4ccd0eb0f`, v2/v3 signed, aligned, zero requested permissions and 39/39 source assets. It is a test candidate, not a store release.
- **Installed phone state:** that exact APK is installed on the connected owner test phone / Android 13. A fresh pull of the installed `base.apk` matched the published APK hash. Release 0.2.3/code 5 was updated in place; separate debug 0.2.2-debug/code 4 retains its original timestamps. No uninstall, clear-data, note read or migration occurred. Device identifiers and screenshots remain in the ignored private audit, not public Git.
- **Desktop:** no Noo Start app or Noo-named desktop/Start-menu PWA shortcut was found. A browser tab is not an installed PWA. The public PWA remains installable; the private notebook is Android-only.
- **Verification:** fresh 2026-10-30 checks pass: 31/31 tests, UI smoke, 30-file distribution boundary, zero npm vulnerabilities, Android debug/release builds and release lint (0 errors, 13 warnings). Fresh unsigned release SHA-256 is `d563271f26886ed47be7ed42b963c1eb90873a11c4eed48ecd4155b1bd881103`.
- **Data boundary:** the installer starts empty. Personal observations, context, corrections, acknowledgment and exports stay in app/browser storage or an owner-chosen export location; waitlist addresses stay server-side. Research, chats, drafts, keys, credentials, screenshots, caches and historical APKs are development/private evidence and are not release inputs.
- **Associated projects:** this repo is the build/deploy authority. MyPersonas holds the Cillian identity, public-source mirror and private planning/research; its focused PR #30 merged as `e10f9f1` and the 30-file mirror now matches canonical Noo bytes. Castleborn supplies fictional canon; AliaSpaces is the associated persona/social surface, not a runtime dependency. See `docs/PROJECT-STOCKTAKE-2026-10-30.md`.

## 4. Blockers

- Native export/import, process-restart, long-session, complete three-launcher and accessibility acceptance remain pending. Another app is currently the phone's foreground workflow; do not take it over without exclusive device access.
- Desktop PWA installation remains unverified and is distinct from Android/private-notebook acceptance.
- Mission 11 reuses Mission 04's image, and the site's existing “human-reviewed” language lacks a located named, signed, hash-bound review record. Owner disposition plus qualified review is required; models cannot self-approve it. Missions 12–15 remain held.
- HTTP→HTTPS, `www`→apex and then HSTS are account/edge decisions, not repository-only changes.
- Current store eligibility, privacy/legal/accessibility review, iOS native delivery, remote sync, staffed community, newsletter operations and ingredient commerce remain separate gated tracks.

## 5. Next actions

Use docs/TRANSFER-ACCEPTANCE.md for scheduled native transfer acceptance. Synthetic browser checks pass; Android provider completion remains unverified.

1. Preserve both Android packages and their separate data stores; with exclusive phone access, complete native export/import/restart, all three launchers and accessibility checks.
2. Install and verify the public PWA on desktop if the owner wants a desktop shell; do not describe that as installing the private notebook.
3. After future canonical public changes, update the MyPersonas mirror through another focused exact-parity change; never copy private `outputs/` material into either public repository.
4. Resolve Mission 11 and name accountable reviewers before any held mission or ingredient/benefit content advances.
5. Stage edge redirects before considering HSTS; reverify live bytes and headers after each provider change.
6. Treat store submission, iOS, sync, community, newsletter and commerce as independent releases with their own evidence and approvals.

## 6. Map

`public/`: production website/PWA payload. `mobile/`: private observation notebook source and Android wrapper. `docs/`: engineering, release and data-boundary records. `deploy/docker/`: optional public-site mirror config, not an installed service. MyPersonas `nooyouniverse.com/`: reconciled public-source mirror, updated only from canonical Noo. MyPersonas `outputs/cillian-noo-youniverse/`: private research/planning, never a runtime or release input.

## 7. Verification

From `mobile/`: run `npm ci`, `npm test`, `npm run smoke`, `npm run verify-distribution`, `npm audit --audit-level=high`, source-build Android, then inspect identity, signature, permissions, backup exclusions, alignment and 39/39 assets. Run `python mobile/scripts/verify-live.py` for production byte readback. Build, package, publish, install and hands-on acceptance are separate evidence states.

## 8. Work log

- 2026-10-30 · Codex: expanded browser smoke with synthetic file-input import, duplicate-merge stability, malformed/unsupported import atomicity, bridge payload/retry and reload checks; all passed. Added docs/TRANSFER-ACCEPTANCE.md with native picker cancellation/save/readback, fixture isolation and receipt requirements. No phone operations or runtime/package changes. Separate release installation is not a declared canonical production-lineage decision or debug migration.

- 2026-10-30 09:15 UTC · Codex GPT-6: completed the fresh cross-chat/repository/live/package/device/data reconciliation. Reverified 29/29 live files, headers, published ZIP/APK hashes/signature and byte-identical installed APK without reading phone data. Fresh source checks: 31/31 tests, smoke, 30-file distribution boundary, audit 0, Android debug/release builds and release lint 0 errors/13 warnings, 39/39 assets. Replaced stale 0.2.2/installation-hold documentation with current 0.2.3 truth; added the project/data stocktake and environment/key ignore patterns; generalized public device/owner metadata. MyPersonas PR #30 merged the exact 30-file public mirror and PR #31 added equivalent environment/signing-file protections; all required checks passed. GitHub description retained and homepage set. No new website payload, APK, health claim, mission, provider row or personal record changed; no store/iOS/sync/community/newsletter/commerce action.

- 2026-10-30 UTC: runtime commit 40b2b8f builds 0.2.3/code 5 with onNewIntent routing. 31 tests and release build/lint pass. Signed and installed APK SHA-256 8a9c7fc1d32ec60771fbfa057ceb6d9bc92e88d2a46b7bb4c1ebb9410d419e27. Release package updated in place; debug version/timestamps unchanged. No notes read, migrated, deleted or included in package. Cold offline site and notebook acknowledgment rendered; complete launcher sequence remains unaccepted amid concurrent phone use.

- 2026-10-30 UTC / 2026-10-29 Alaska · Codex GPT-6: PR #6 merged (b26a79f); Cloudflare deployment and 29/29 raw asset readback verified. Signed APK SHA-256 3cd9ade325fd0b8621ac64d77ee9940dca2683f2d9abc10fa4c6bdbe181f9728 published as a test prerelease, not a store release. Added repeatable APK/live verification scripts and personal-data boundary docs. No phone install, no successful desktop install, no personal data deletion/migration or private research upload. Historical branches and dirty checkout preserved. Private local inventory/handoff remains in the owner checkout; this public-safe root file is committed with release evidence.

- 2026-10-29 · Codex GPT-6: integrated verified Android identity/backup/import fixes, public accessibility/disclosures/cache update, 30-file distribution allowlist and two contamination tests. Private research, held mission art, keys and owner data excluded from this clean release history. Final packaging and publication remain in progress.

- 2026-10-29: isolated release worktree created from freshly fetched origin/main. No owner worktree reset or history rewrite.
