# Noo YouNiverse — agent handoff

Read this file, `docs/MOBILE-ROADMAP.md`, `public/log.html`, and `public/sources.html` before changing anything.

## What this repository is

`Justice-Write/nooyouniverse` is the **deploy repo** for the static site. Cloudflare Workers serves only `public/`. The long-form site roadmap lives in MyPersonas at `nooyouniverse.com/SITE-ROADMAP.md`.

Cillian O'Sullivan is a fictional, AI-assisted, human-reviewed Castleborn character. Content is educational only. Nothing here is medical advice.

## Approved missions

The live Mission Log on `main` is the canon this checkout may use:

- Missions **01–11** in `public/log.html`
- Source-basis badges and ledger in `public/sources.html`

Do **not** invent missions, curriculum, evidence tiers, sensor data, or clinical claims. The caffeine entry on `cursor/caffeine-context-variable-af50` is an unapproved draft. Package A drafts (MyPersonas outputs) are slated as Missions 12–15, unapproved, not in this repo; their art brief is `docs/CLAUDE-DESIGN-BRIEF-missions-12-15.md`.

## Public-site honesty

Mission 09 and the homepage waitlist describe an **unbuilt / not-released product**. A private debug prototype in `mobile/` does not make the public site a released tracker. Do not change waitlist or Mission 09 copy to claim store availability, measurements, prescriptions, or FDA status.

## Mobile milestone 1

`mobile/` is a **private, on-device observation log** plus a debug **check hub** that also ships an offline snapshot of `public/`.

- Observations are notes, not medical measurements.
- No sensors, no invented vitals, no dosing, no diagnosis.
- Persistence is local (`localStorage` / Android WebView DOM storage).
- Export/import is versioned JSON (`noo-private-observation-log` v1) and rejects unknown missions and clinical/measurement fields.
- Edits keep an append-only correction history. Users can wipe all notes on device. A 21+ / not-medical acknowledgment is stored separately from notes.
- Test fixtures in `mobile/tests/fixtures/` are synthetic. The app starts empty.
- Existing owner phone-test prototypes are local and are **not** in this cloud checkout. Do not claim access to them. If package/signing identity differs, preserve the existing install and export; stop for exact device/migration approval. Never uninstall or clear data to bypass a mismatch.

## Commands

```bash
cd mobile
npm test
npm run smoke   # headless Chrome, skipped if Chrome/puppeteer-core missing
npm run serve   # http://127.0.0.1:4173
```

Android APK: `docs/BUILD-ANDROID.md`. Historical Gradle-free repacks are not current release acceptance evidence; source-built exact-artifact verification is required. Signing and physical installation remain held. Release key: `_ops/keystores/`, never in git.
Desktop / self-host: `docs/DESKTOP.md`, `deploy/docker/`.
Owner phone sideload + hub (held; historical recipe): `docs/DEVICE-INSTALL.md`.
Android Chrome home-screen site (device acceptance held): `docs/ANDROID-HOME-SCREEN.md`.
Phone checklist (not authorization to execute): `docs/PHONE-CHECKLIST.md`.
Historical owner Drive drops are superseded. Do not fetch, refresh or install them while the hold is active.
Human review packet (unsigned): `docs/REVIEW-PACKET.md`.
Store copy drafts — do not submit: `docs/STORE-LISTING-DRAFT.md`.
Remote sync stays gated: `docs/SYNC-BACKLOG.md`.
iOS from this Linux checkout: home-screen PWA only — `docs/IOS-HOME-SCREEN.md`.
Emulator process-death probe: `mobile/scripts/emulator-persistence.sh`.

## Hard limits

Do not merge, deploy, publish to stores, change account permissions, use production secrets, or start paid services unless a human explicitly asks. Store accounts may be verified; submissions are later. Do not implement remote sync until `docs/REVIEW-PACKET.md` is signed. Prefer small, honest diffs. Keep public `public/` architecture intact unless the task is a site change.
