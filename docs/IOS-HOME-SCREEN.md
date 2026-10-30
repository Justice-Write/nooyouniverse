> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# iOS home-screen path

> **2026-10-23 hold:** the live PWA files are deployed, but no physical iPhone
> install/persistence acceptance has been run. Do not install while the
> portfolio installation hold is active. No current store-account or signing
> readiness is inferred here.

## Two separate surfaces

**Public website PWA:** `https://nooyouniverse.com` has live PWA files for the
public website only. It does **not** contain the private observation log. A
future owner-authorized iPhone acceptance pass may use Safari → Share → Add to
Home Screen, then verify public-site install/update/offline behavior. That
physical-device action remains held.

**Private observation log:** `mobile/web` contains local PWA-capable files, but
there is no current iOS distribution or installation path. `npm run serve`
binds a development origin on the computer; it does not create an authorized,
secure, installable iPhone host. Do not expose the private log on a public host
without a new privacy, security and release decision. A future authorized path
must define the trusted HTTPS origin (or a Mac/Xcode build), data boundaries,
backup/export behavior and real-iPhone persistence acceptance first.

Android source separately includes an offline site/log/hub package, but every
existing signed/debug APK is blocked from owner-device installation
(`docs/DEVICE-INSTALL.md`).

## What this is not

- Not an App Store build
- Not TestFlight
- Not a private-log iOS distribution path
- Not a claim that iOS persistence was physically verified on an iPhone
- Not a reason to change public Mission 09 / waitlist copy

If a later Mac build uses a different signature than any local prototype, export JSON first and import. Owner phone prototypes are local and are not in this checkout.
