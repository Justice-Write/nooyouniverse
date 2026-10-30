# Runtime files and personal data

Updated 2026-10-29. The application starts with an empty notebook. Personal data is not required to install or run it.

| Category | Runtime requirement | Distribution policy |
|---|---|---|
| Website HTML/CSS/JS, images, icons, manifest and service worker | Website/offline copy | Reviewed public asset allowlist only |
| Notebook code, mission catalog, Android classes/resources | App | Code and catalog, never populated storage |
| Observations, context, uncertainty, corrections, acknowledgment | User-created | Android WebView/browser local storage, separate from program files |
| Exported observation JSON | Optional backup | Private owner-chosen location, never APK/website/Git/release ZIP |
| Waitlist email addresses | Existing server-side service only | Never download into the installer |
| Research, strategy, drafts, unpublished media, chat histories | None | Private workspace outside public history/releases |
| Signing keys/passwords, browser credentials, service tokens | Build/admin tooling only | Never commit or package |
| Tests, fixtures, screenshots, old APKs, build caches | Development/evidence only | Exclude from runtime payload |

## Persistence and migration

The notebook uses `noo.observationLog.v1` and a separate `noo.observationLog.ack.v1` key. Android stores these in its app-specific WebView data; browser storage belongs to the browser profile and origin. Moving program files does not migrate those records. Installing the public-site PWA does not install the private notebook or copy its data.

Export/import uses `noo-private-observation-log` v1. Exports contain personal free text and correction history. They are ordinary JSON, not encrypted backups. Android excludes private app data from cloud backup and device transfer, so explicit export is important before an uninstall or device replacement.

Never clear data or uninstall to resolve a signing conflict. Preserve the old installation and export first; compare package/certificate identities before an update. Distinct package IDs can coexist. Renaming an APK does not change its package or signer.

## Enforced boundary

`npm run verify-distribution` rejects missing/unexpected public files and symbolic links/junctions. Android bundling calls it before replacing its offline copy. Tests inject a synthetic backup and directory link and prove rejection. This is a path-level safeguard, not content approval: every edit inside an allowed file still needs review.

Release inspection compares packaged assets with generated source assets and checks package identity, permissions, backup rules and signature. Older APKs in Git history are retained evidence, not current installation instructions.

## Inventory coverage

The October 29 audit searched relevant worktrees and filenames under Documents, Downloads and Desktop, checked the private workspace/recovery records and enumerated storage roots. It did not export browser databases, note contents or waitlist rows. Name-based search cannot rule out generically named copies on other disks. No personal files were deleted or relocated.
