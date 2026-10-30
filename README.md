# Noo YouNiverse

Evidence-literacy missions hosted by Cillian O'Sullivan, a fictional AI-assisted character, and a separate local-first observation notebook. Observations are not clinical measurements. Educational software; not medical advice or a store-approved health product.

Read [status-handoff.md](status-handoff.md) first. See the [current release](docs/RELEASE-2026-10-29.md), [project stocktake](docs/PROJECT-STOCKTAKE-2026-10-30.md), [data boundaries](docs/DATA-BOUNDARIES.md), and [roadmap](SITE-ROADMAP.md).

## Components

- `public/`: website, eleven existing missions, sources/corrections and browser-installable PWA. Cloudflare serves only this directory.
- `mobile/web/`: private-on-device notebook and check hub; no accounts or remote sync.
- `mobile/android/`: source-built Android wrapper, three launcher entries, local storage and explicit JSON export/import; no Internet or sensor permission.
- `deploy/docker/`: optional public-site mirror configuration, not an installed service.

The historical source mirror is `MyPersonas/nooyouniverse.com`. Parallel changes remain there; do not overwrite this reviewed release from an older checkout. This repository's release commit is the build/deploy authority; reconcile the mirror explicitly.

## Verify and build

From `mobile/`: `npm ci`, `npm test`, `npm run smoke`, `npm run verify-distribution`. Use the committed Gradle wrapper for Android, then verify package/permissions/backup rules/assets and signature. See [build instructions](docs/BUILD-ANDROID.md). Historical repacks are not accepted releases.

`mobile/scripts/public-assets.json` lists the 30 reviewed public files. Unexpected files or links stop offline bundling. Every change within an allowed file still needs review. Keep exports, research, credentials, keys and device/browser profiles outside release payloads.

## Release and install

`wrangler.jsonc` publishes only `public/`. A push is not proof of deployment: verify live bytes, service worker and headers. Desktop installation uses the public-site PWA; it does not install the private notebook.

Use only the candidate identified in the current release record. The exact 0.2.3/code 5 candidate is installed on the verified Android 13 owner test phone; that does not complete hands-on launcher/export/accessibility acceptance. Historical 0.2.0/0.2.1/debug APKs are not upgrade instructions. Verify device, package and signer before any future update; preserve existing notes. Store submission is separate.
