> Current technical release authority and authorization: status-handoff.md and docs/RELEASE-2026-10-29.md. Historical hold/parity statements below must be read against that record. Never publish private planning or unapproved content.

# Noo YouNiverse — agent handoff

> ## ⚠️ READ `status-handoff.md` IN THIS FOLDER FIRST
>
> `status-handoff.md` is the single entry point and the live status of record. It carries a **mandatory operating rule**: claim your work in its §1 *In progress* *before* you start, and move the entry to §8 *Work log* *after* you finish or stop. Multiple agents (Codex, Cursor, Claude Code, ChatGPT, Claude Cowork) work here concurrently — §1 is how you avoid colliding with them.
>
> This file (`AGENTS.md`) remains the canon contract for *what* you may change. `status-handoff.md` tells you the current *state* and *who is doing what right now*.

Read `status-handoff.md`, then this file, `docs/MOBILE-ROADMAP.md`, `public/log.html`, and `public/sources.html` before changing anything.

## What this repository is

`Justice-Write/nooyouniverse` (renamed from `castleism/…`) is the **deploy repo** for the static site. Cloudflare Workers serves only `public/`. The current long-form site roadmap is on the unpushed MyPersonas branch `codex/noo-source-parity-20261023` at `aaf212fa59b20d6b5deea8b3bd3598eec4aa533a`; the MyPersonas owner checkout and `origin/main` remain stale until that focused branch is reviewed and integrated.

Cillian O'Sullivan is a fictional, AI-assisted, human-reviewed Castleborn character. Content is educational only. Nothing here is medical advice.

## Approved missions

The live Mission Log on `main` is the canon this checkout may use:

- Missions **01–11** in `public/log.html`
- Source-basis badges and ledger in `public/sources.html`

Do **not** invent missions, curriculum, evidence tiers, sensor data, or clinical claims. The caffeine entry on `cursor/caffeine-context-variable-af50` is an unapproved draft. Package A drafts (MyPersonas outputs) are slated as Missions 12–15, unapproved, not in this repo; their art brief is `docs/CLAUDE-DESIGN-BRIEF-missions-12-15.md`.

## Public-site honesty

Mission 09 and the homepage waitlist describe an **unbuilt / not-released product**. A private local prototype in `mobile/` does not make the public site a released tracker. Do not change waitlist or Mission 09 copy to claim store availability, measurements, prescriptions, or FDA status.

## Mobile milestone 1

`mobile/` is a **private, on-device observation log** plus a local **check hub** that also ships an offline snapshot of `public/`.

- Observations are notes, not medical measurements.
- No sensors, no invented vitals, no dosing, no diagnosis.
- Persistence is local (`localStorage` / Android WebView DOM storage).
- Export/import is versioned JSON (`noo-private-observation-log` v1) and rejects unknown missions and clinical/measurement fields.
- Edits keep an append-only correction history. Users can wipe all notes on device. A 21+ / not-medical acknowledgment is stored separately from notes.
- Test fixtures in `mobile/tests/fixtures/` are synthetic. The app starts empty.
- Existing owner phone-test prototypes are not available to this repository checkout; do not claim access to them. Side-by-side is possible only when package IDs differ. If the package ID is the same but the signer differs, stop and preserve the old app/export; never uninstall or clear data to bypass the mismatch.

## Commands

```bash
cd mobile
npm test
npm run smoke   # headless Chrome, skipped if Chrome/puppeteer-core missing
npm run serve   # http://127.0.0.1:4173
```

Android APK: `docs/BUILD-ANDROID.md`. Current candidates must be source-built with Gradle; the historical Gradle-free repack path is not release acceptance evidence. Release key: `_ops/keystores/`, never in git.
Desktop / self-host: `docs/DESKTOP.md`, `deploy/docker/`.
Owner phone installation remains on hold: `docs/DEVICE-INSTALL.md`.
Android Chrome home-screen site (also held pending owner/device acceptance): `docs/ANDROID-HOME-SCREEN.md`.
Phone checklist (not executable while the hold is active): `docs/PHONE-CHECKLIST.md`.
Any older Drive APK/install-note bundle is superseded and must not be installed or refreshed.
Human review packet (unsigned): `docs/REVIEW-PACKET.md`.
Store copy drafts — do not submit: `docs/STORE-LISTING-DRAFT.md`.
Remote sync stays gated: `docs/SYNC-BACKLOG.md`.
iOS: only the **public-site** PWA files are live (physical install held); the private observation log has no iOS distribution path. A native build would require a separately authorized Mac/Xcode/signing workflow — `docs/IOS-HOME-SCREEN.md`.
Emulator process-death probe: `mobile/scripts/emulator-persistence.sh`.

## Hard limits

Do not merge, deploy, publish to stores, change account permissions, use production secrets, or start paid services unless a human explicitly asks. Store accounts may be verified; submissions are later. Do not implement remote sync until `docs/REVIEW-PACKET.md` is signed. Prefer small, honest diffs. Keep public `public/` architecture intact unless the task is a site change.
