> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Android — save the live website as a browser app

This repository cannot push an icon onto the owner's phone. The portfolio-wide
installation hold is active, so the steps below are a future acceptance
checklist, not permission to install either the PWA or an APK.

PWA files (`public/manifest.webmanifest`, maskable PNG icons, `public/sw.js`,
`public/pwa-register.js`) meet Chrome's install fields and were reverified live
at `https://nooyouniverse.com` on 2026-10-23. This proves the web delivery
surface, not physical-device installation or acceptance.

## Live site (Chrome)

1. Open Chrome on the phone.
2. Visit `https://nooyouniverse.com/` (or use **Live in Chrome** on the Check Hub APK).
3. Tap ⋮ → **Add to Home screen** or **Install app**.
4. Name it **Noo YouNiverse**.
5. Repeat if you also want a shortcut that opens `/log` directly (optional).

That icon is the **live** website. Waitlist submit works there. It is not the private observation log.

## Observation log + offline site copy

Those are intended to live in a future corrected release APK
(`docs/DEVICE-INSTALL.md`). The package declares **three** launcher entries;
their physical-device presentation remains unaccepted:

- **Noo YouNiverse** — offline snapshot of `public/`
- **Noo Observation Log** — private notes app
- **Noo Check Hub** — every page and live Chrome link to look at

Old APK copies may still exist in the owner Drive folder **Noo YouNiverse —
phone check**. They are superseded and must not be installed. No corrected
signed APK has been placed there.

Do not confuse the Chrome home-screen icon (live site) with the Android package
launcher entries (offline site, observation log and hub).
