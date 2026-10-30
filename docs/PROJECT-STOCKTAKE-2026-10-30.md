# Noo YouNiverse project stocktake

Updated 2026-10-30. This is a public-safe map for humans and AI assistants. Private chat IDs, owner records, research content, credentials and personal observations stay outside public Git history.

## Authority and associated projects

| Project or surface | Role | Authority boundary |
|---|---|---|
| `Justice-Write/nooyouniverse` | Website, PWA, private-notebook source, Android wrapper, release evidence | Canonical build and deploy source |
| `Justice-Write/MyPersonas` | Cillian identity, reconciled `nooyouniverse.com/` mirror, owner-control platform | Public-source mirror and shared platform; not Android build authority |
| Private `MyPersonas/outputs/cillian-noo-youniverse/` | Strategy, research, drafts, compendium, supply-chain and review materials | Private planning only; never package or publish by directory sync |
| Castleborn | Fictional-character canon | Identity/canon dependency, not a software dependency |
| AliaSpaces / MyPersonas profile | Cillian's associated persona/social surface | Separate release and account gates |
| Shared Android test lab | Historical prototypes, signers and device evidence | Evidence source only; current candidate is identified by exact package, signer, source and hash |

Repository, live-site, release-asset and device readback evidence supersedes older chat status. Related chats are planning/evidence lanes, not independent sources of release truth.

## Verified surfaces

| Surface | Verified current state | Not yet accepted |
|---|---|---|
| Website/PWA | `main` at `73035f0`; 29/29 public files match live; core security headers present | HTTP/apex redirects and HSTS |
| Android release | 0.2.3/code 5 prerelease packaged; exact signed APK installed and read back from the Android 13 owner test phone | Full launcher, native export/import, restart and accessibility sequence |
| Android debug | Separate 0.2.2-debug/code 4 install preserved | No migration to release app; none implied |
| Desktop | Edge installation and standalone launch evidenced; independent StartApps registration readback | Physical offline/accessibility acceptance pending; no notebook migration |
| Missions | 01–11 public; 12–15 absent | Mission 11 disposition/review record; all held content approvals |
| Waitlist | Public form exists; server data is not installer data | Provider/account and subscriber operations remain separate |

The MyPersonas mirror reconciliation merged through PR #30 at `e10f9f1`; its 30 public files matched canonical Noo `main` byte-for-byte at merge time. This did not deploy either site.

## Data and package boundary

| Data class | Needed to run? | Where it belongs |
|---|---:|---|
| Reviewed HTML/CSS/JS, images, icons, manifest, service worker | Yes, website/offline shell | `public/` and approved Android offline copy |
| Notebook code, mission catalog, Android classes/resources | Yes, Android notebook | Source/APK, with empty initial storage |
| Observation text, context, uncertainty, corrections, acknowledgment | No preloaded data | App-specific WebView/browser local storage only |
| Exported observation JSON | Optional personal backup | Owner-selected private location; unencrypted, never APK/Git/release ZIP |
| Waitlist email addresses | No | Server-side service only; never installer or repository |
| Research, drafts, compendium, supplier work, chats, approvals | No | Private workspace; exact reviewed excerpts only may enter future releases |
| Signing keys, passwords, tokens, browser profiles | No | Private admin/build storage; never Git or package |
| Tests, synthetic fixtures, screenshots, logs, old APKs, caches | No | Development/evidence storage; exclude from runtime payload |

The October inventory covered known repositories/worktrees, private Noo workspace pointers, release/recovery records, Desktop/Documents/Downloads filename matches, the connected Android packages and common desktop-install surfaces. It did not read observation contents, subscriber addresses, browser databases, credentials or unrelated personal files, and it cannot prove the absence of generically named copies on disconnected storage.

## Roadmap order

1. Finish exclusive-device and desktop PWA acceptance without altering personal records.
2. Keep the MyPersonas public mirror exact while preserving the deploy repo as build authority.
3. Resolve Mission 11 and establish named, hash-bound review records.
4. Advance Missions 12–15 only after editorial/source/health/privacy/legal/accessibility approval.
5. Reverify edge redirects, provider accounts and store eligibility as independent external gates.
6. Keep community, questionnaire, newsletter, remote sync and commerce as separate products with explicit data, moderation, legal and operational decisions.
7. Before another Android version, add tested WebView defense in depth: reject unknown schemes, minimize file/content cross-origin access and scope the native bridge while preserving offline assets and JSON import.

See `status-handoff.md`, `SITE-ROADMAP.md`, `docs/RELEASE-2026-10-29.md`, `docs/MOBILE-ROADMAP.md` and `docs/DATA-BOUNDARIES.md` for executable detail.
