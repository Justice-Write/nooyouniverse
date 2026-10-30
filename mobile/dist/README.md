# APKs (historical evidence only — no installable candidate)

> **2026-10-23 hold:** Do not install or distribute any APK in this directory.
> Both signed release files predate the release-identity and Android
> backup/transfer fixes. Corrected 0.2.2 / code 4 source at exact commit
> `a757914428e6d4becf3abf8fc8f0056530a611ba` produced local unsigned release
> SHA-256 `889f2df1d3e4a6192624215727a988776263ed250609f47e56a99086cf192e6b`.
> The portfolio installation hold is
> still active.

| File | Package id | Version | Signature | Use |
|---|---|---|---|---|
| `noo-observation-log-0.2.0-release.apk` | `com.nooyouniverse.observationlog` | 0.2.0 (versionCode 2) | **release key** `noo-release-2026.jks` (SHA-256 `1241938b…eb0f`), v2+v3 | **Blocked historical artifact. Do not install.** Release resources retained debug identity values. |
| `noo-observation-log-0.2.1-release.apk` | `com.nooyouniverse.observationlog` | 0.2.1 (versionCode 3) | same release key, v2+v3; APK SHA-256 `8bd8b9c0ba03de4174030819e2c6a49563a5f4192b13fa8cfb4d0b3a401122c5` | **Blocked local ignored historical artifact; it may be absent from a clean clone. Do not install.** Built before the identity and backup-boundary fixes. |
| `noo-observation-log-debug.apk` | `com.nooyouniverse.observationlog.debug` | 0.1.0-debug | debug keystore of the 2026-09-25 cloud build | Historical emulator/probe input only. Do not put it on the owner's device while the hold is active. |

The intended release surface is three launcher entries: **Noo YouNiverse**
(offline site copy), **Noo Observation Log** and **Noo Check Hub**. Do not use
these old files to validate that surface: their release resource identity is
known to be wrong.

- These are not Play Store / App Store artifacts. Do not submit, install or redistribute them.
- The corrected local 0.2.2 / code 4 unsigned build exists only under ignored Gradle output at `mobile/android/app/build/outputs/apk/release/app-release-unsigned.apk`; it is not a release artifact and must not be copied into this folder until signing and complete post-sign verification are owner-authorized.
- Any old copy in the owner Drive folder `Noo YouNiverse — phone check` is superseded by this hold notice.
