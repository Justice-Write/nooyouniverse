> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Owner device install — sideload + home-screen playbook

**2026-10-23: portfolio-wide installation hold remains active. Do not execute
any install, uninstall, update or browser-app installation recipe below until
that gate is explicitly released. There is currently no approved installable
APK.**

An old APK/install-note bundle may remain in the owner Drive folder. It is
historical and superseded by this hold; do not fetch or install it. This local
checkout cannot perform or prove launcher acceptance on the owner's device.

**Do not install:** `mobile/dist/noo-observation-log-0.2.0-release.apk`,
`mobile/dist/noo-observation-log-0.2.1-release.apk`, or the debug APK. The two
signed releases predate the verified release-identity and Android
backup/transfer fixes. Their presence is historical evidence, not acceptance.

Corrected source is version 0.2.2 / `versionCode 4`, package
`com.nooyouniverse.observationlog`; that version/artifact identity avoids
collision with the rejected signed 0.2.1 version. Exact implementation commit
`a757914428e6d4becf3abf8fc8f0056530a611ba` produced unsigned release SHA-256
`889f2df1d3e4a6192624215727a988776263ed250609f47e56a99086cf192e6b`.
This is **not** installable approval. Before this playbook becomes executable,
that exact unsigned hash must be signed in an owner-authorized session,
rechecked after signing, assigned a signed SHA-256 and named here.

Existing phone-test prototypes and their data are **not** available to this
repository checkout. Do not overwrite them.

## What the APK now contains

| Home-screen / in-app card | What it is |
|---|---|
| **Check hub** (opens first) | List of every website and app to look at |
| **Offline website copy** | Snapshot of `public/` (home, /log, /sources, /corrections, images) |
| **Private observation log** | On-device notes for missions 01–11 |
| **Live in Chrome** links | Real `https://nooyouniverse.com` and AliaSpaces pages |

The candidate still has **no** `INTERNET` permission. Live links hand off to
Chrome. Waitlist submit only works on the live site. The **Noo YouNiverse** APK
launcher entry is an offline website copy; it is separate from the live Chrome
PWA, whose manifest/service worker are already deployed.

## Preserve data if signing differs

Android will refuse an upgrade when the signature does not match.

1. Open the **old** install.
2. Transfer → Download JSON (keep that file off-device if you want a spare).
3. After a new signed candidate is approved, install it **side-by-side only if
   the package ID differs**. If the package ID is the same but the signer
   differs, stop: Android will reject the update. Preserve the old app and its
   export; do not uninstall or clear data to work around the mismatch.
4. Only in an approved side-by-side/new-install path, use Transfer → Import
   (merge). Never replace until you have checked the export.

## Android sideload (personal Google account)

1. Enable Install unknown apps for the Files / browser app you will use.
2. Copy only the newly signed, hash-verified candidate named in a later evidence record to the phone. Do not use either historical signed file currently in `mobile/dist/` or an old Drive copy.
3. Install. Accept only the sideload prompt — this APK requests **no** network, sensors, or accounts.
4. The package declares **three launcher entries**; verify their actual launcher
   presentation on the physical device (not yet accepted):
   - **Noo YouNiverse** — saved website (offline copy of home, /log, /sources, /corrections)
   - **Noo Observation Log** — the notes app we are building
   - **Noo Check Hub** — every page and live Chrome link to check
5. Open **Noo YouNiverse** and tap through Home → Mission Log → Sources → Corrections.
6. Open **Noo Observation Log**. Accept the 21+ / not-medical gate.
7. Log one ordinary, non-medical observation on Mission 07 (include a null result).
8. Leave the app (Home). From Settings → Apps → Noo Check Hub → Force stop.
9. Reopen. The observation must still be in History.
10. Transfer → confirm export format `noo-private-observation-log`.

## Save the live website as a browser app

See `docs/ANDROID-HOME-SCREEN.md`.

1. After the portfolio installation hold is explicitly lifted, from the hub tap **https://nooyouniverse.com/** (opens Chrome).
2. Chrome ⋮ → **Add to Home screen** / **Install app**.
3. In the intended accepted setup, the APK contributes three launcher entries
   (**Noo Check Hub**, **Noo YouNiverse** offline, **Noo Observation Log**) and
   Chrome contributes a fourth **Noo YouNiverse** icon for the live PWA.

The live-site install uses PWA files in `public/`; they were reverified live on
2026-10-23. A real-device install/update/offline check remains unperformed.

## Tick when done

- [ ] Portfolio installation hold explicitly lifted for this exact candidate
- [ ] Candidate filename, full SHA-256, package, version code and signing certificate matched the fresh evidence record
- [ ] Sideloaded only that newly approved candidate (no historical `mobile/dist/` APK)
- [ ] Hub listed site copy + observation log + live links
- [ ] Offline Mission Log 01–11 readable without radio
- [ ] Gate accepted on the observation log
- [ ] Observation survived Force stop
- [ ] Export opened and looks like notes, not measurements
- [ ] Live site added to the home screen from Chrome
- [ ] Old prototype data preserved

## iOS (public-site PWA only; private log has no distribution path)

See `docs/IOS-HOME-SCREEN.md`. Public-site physical installation is held; the
private observation log has no authorized iOS host or native build.

## Historical debug persistence probe (emulator evidence only)

Debug builds accept an extra that writes `/data/data/com.nooyouniverse.observationlog.debug/files/noo-probe.json`. It is **not** a user-facing feature and is compiled only when `BuildConfig.DEBUG` is true.

The 2026-09-24 emulator result is retained as historical evidence. Do not run
the old install command from this owner-device playbook while the portfolio
hold is active: an unscoped `adb` command could target a connected phone.
`mobile/scripts/emulator-persistence.sh` is now fail-closed: it requires the
explicit `NOO_EMULATOR_PROBE_ACK=AUTHORIZED_EMULATOR_ONLY` acknowledgment, an
explicit `NOO_EMULATOR_SERIAL=emulator-<even-port>`, scopes every `adb` command
to that serial, requires `NOO_EXPECTED_DEBUG_SHA256` to match the separately
built current debug APK, and proves `ro.kernel.qemu=1` before install. It may be used only
in a separately authorized emulator-only session with no owner device
connected. Debug seed/dump open the observation log, not the hub.

## What this playbook is not

Not a Play / App Store install. Not permission to change `public/` waitlist or Mission 09 copy. Not access to the owner’s earlier local prototypes. Not Cursor installing onto your hardware.
