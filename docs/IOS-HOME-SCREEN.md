> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# iOS home-screen path

> **Current state 2026-10-30:** the live PWA files are deployed, but no physical
> iPhone install/persistence acceptance has been run. No current store-account
> or iOS signing readiness is inferred here.

## Two separate surfaces

**Public website PWA:** `https://nooyouniverse.com` has live PWA files for the
public website only. It does **not** contain the private observation log. A
future iPhone acceptance pass may use Safari → Share → Add to
Home Screen, then verify public-site install/update/offline behavior. That
physical-device action remains unverified.

**Private observation log:** `mobile/web` contains local PWA-capable files, but
there is no current iOS distribution or installation path. `npm run serve`
binds a development origin on the computer; it does not create an authorized,
secure, installable iPhone host. Do not expose the private log on a public host
without a new privacy, security and release decision. A future authorized path
must define the trusted HTTPS origin (or a Mac/Xcode build), data boundaries,
backup/export behavior and real-iPhone persistence acceptance first.

Android separately has an installed, hash-verified 0.2.3 offline site/log/hub
candidate (`docs/DEVICE-INSTALL.md`); that does not create an iOS path.

## What this is not

- Not an App Store build
- Not TestFlight
- Not a private-log iOS distribution path
- Not a claim that iOS persistence was physically verified on an iPhone
- Not a reason to change public Mission 09 / waitlist copy

If a later Mac build uses a different signature than any local prototype, export JSON first and import. Owner phone prototypes are local and are not in this checkout.
