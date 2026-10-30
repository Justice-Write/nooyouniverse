> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Phone checklist — websites and apps to look at

> **Current state 2026-10-30:** exact signed 0.2.3/code 5 is installed and
> hash-verified; old Drive/debug/release artifacts remain superseded. Use this
> checklist with exclusive device access, preserve both installed packages and
> existing notes, and create synthetic test data only.

The installed Android candidate declares three launcher
entries. The live Chrome PWA is a separate fourth icon if installed.

## On this device (remaining hands-on acceptance)

- [x] 0.2.3/code 5 package installed and APK read back byte-identical
- [x] Separate 0.2.2-debug/code 4 package/timestamps preserved

- [ ] Three launcher icons: Noo YouNiverse, Noo Observation Log, Noo Check Hub
- [ ] Check hub opens
- [ ] Offline home (`public/index.html` snapshot)
- [ ] Offline Mission Log 01–11
- [ ] Offline Sources
- [ ] Offline Corrections
- [ ] Observation log gate (21+ / not medical)
- [ ] One non-medical note saved
- [ ] Note still there after Force stop
- [ ] JSON export is `noo-private-observation-log`

## Live in Chrome (needs radio)

- [ ] https://nooyouniverse.com/
- [ ] https://nooyouniverse.com/log
- [ ] https://nooyouniverse.com/sources
- [ ] https://nooyouniverse.com/corrections
- [ ] https://nooyouniverse.com/#waitlist (submit only works here)
- [ ] https://mypersonas.online/#/p/castleborn.cillian
- [ ] https://mypersonas.online/privacy.html
- [ ] https://mypersonas.online/data-deletion.html
- [ ] Chrome → Add to Home screen for the live site (`docs/ANDROID-HOME-SCREEN.md`)

## Still not on this list (on purpose)

- Instagram / Facebook / X until those accounts are used on purpose
- Play / App Store listings (drafts only: `docs/STORE-LISTING-DRAFT.md`)
- Remote sync (`docs/SYNC-BACKLOG.md`)
- Missions 12–15 (private drafts/art candidates, not catalog canon)
