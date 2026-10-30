> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Desktop — local preview, future app install, or self-host

> **Current state 2026-10-30:** the public PWA is live and browser-usable, but
> no installed Noo Start-menu/desktop shortcut was found. Installing that PWA
> is separate from installing the private Android notebook. The self-hosted
> mirror remains optional and unpublished. Use synthetic data for previews.

There is no separate desktop program and none is planned. The public site and
the private observation log are both web apps with PWA-capable source. The
public site can additionally be self-hosted as a container after a separate
release decision. Anything heavier (Electron/Tauri) would add an update
channel and a signing chain for no currently approved capability.

## Public-site desktop acceptance

Chrome / Edge / Brave
(Windows, macOS, Linux) can be checked as follows:

1. Open https://nooyouniverse.com.
2. Address bar → the **Install** icon (or ⋮ → *Cast, save and share* → *Install
   page as app…*).
3. It opens in its own window with the Noo YouNiverse icon; `/log`, `/sources`
   and `/corrections` are pinned as app shortcuts (right-click the taskbar
   icon).

What the source intends: the network-first shell from `public/sw.js` prefers a
fresh network response and falls back to cached content or the offline page
when the network is unavailable. That behavior still needs platform acceptance.
Safari on macOS: File → *Add to Dock* (Sonoma+). Firefox has no desktop PWA
install; bookmark it.

## Preview the private observation log on desktop

```bash
cd mobile && npm run serve      # http://127.0.0.1:4173
```

Open the local URL for preview/testing only; do not enter real
private observations. Browser-profile storage may
persist local test notes. `localhost` is a secure context, so service-worker
behavior can be tested without publishing the private log.

## Self-host / virtual appliance

`deploy/docker/` — nginx (unprivileged, port 8080) serving `public/` with the
same clean URLs, 404 page and security headers Cloudflare applies. See
`deploy/docker/README.md`; `deploy/docker/verify.sh` proves parity against a
running instance. Cloudflare remains canonical; this is a mirror for a home
server, a NAS, or an air-gapped demo.

## Agents

No server-side agents exist and none are gated open: the app has no network
permission and `docs/SYNC-BACKLOG.md` keeps remote sync closed until the
review packet is signed. The only automation is the repo's own scripts
(`mobile/scripts/*`, `deploy/docker/verify.sh`).
