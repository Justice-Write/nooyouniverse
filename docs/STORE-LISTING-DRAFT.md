> Current release status: see [RELEASE-2026-10-29.md](RELEASE-2026-10-29.md). Earlier hold and branch statements below are historical; rejected old APKs remain rejected.

# Store listing drafts — **do not submit**

A prior project note says a Google personal account was verified, but that
access was not rechecked on 2026-10-23; Apple account/signing readiness is
unverified. **Submissions stay later.** This file is copy and Data Safety
answers for a future human upload. Agents must not open Play Console / App
Store Connect or press Submit without fresh exact owner authorization.

If any line below would make the public site or Mission 09 a product claim, it is still a **draft**.

## Shared facts (both stores)

- App name (debug / internal): Noo Observation Log
- Future public name (owner to confirm): Noo YouNiverse Observation Log
- Category: Health & Fitness is a poor fit if it implies medical use. Prefer **Lifestyle** or **Education** unless a lawyer says otherwise.
- Age: 21+. Do not target children.
- Short description: Private on-device notes linked to published Noo YouNiverse missions. Observations, not measurements. Educational only. Not medical advice.
- Full description (draft):

  Noo YouNiverse’s observation log is a private notebook. You pick one **already published** mission, write down one ordinary thing you chose to watch, the surrounding context, what you expected, and what happened — including “nothing noticeable.” Uncertainty is a label you choose. The app does not read sensors, invent vitals, prescribe, dose, or diagnose. Notes stay on the device unless you export them. Cillian is a fictional, AI-assisted, human-reviewed character.

- Keywords to **avoid**: clinical, FDA, treatment, cure, stack, dose, medically proven, wellness tracker (if it implies wearables).

## Google Play Data Safety (draft answers)

| Data type | Collected | Shared | Purpose |
|---|---|---|---|
| Health info | No | No | — |
| Location | No | No | — |
| Personal info (name, email) | No | No | — |
| Photos / files | User-chosen export/import only; not uploaded by the app | No | User backup |
| App activity / analytics | No | No | — |
| Device IDs | No | No | — |

- Encrypted in transit: N/A based on current release source/merged-manifest
  evidence showing no `INTERNET` permission; reverify the exact signed
  submission artifact before answering in a store console.
- User-controlled deletion: in-app wipe. A user may deliberately uninstall the
  app, but uninstall must not be used as a migration/signature-mismatch
  workaround. No server copy exists to delete.
- Data is not sold.
- Independent security review: **not claimed**.

## App Store privacy nutrition (draft)

- Data Not Collected, unless a future iOS binary uses iCloud (it must not, unless a later review says so).
- Medical research / health: do not enable HealthKit.

## What must exist before a human submits

- [ ] `docs/REVIEW-PACKET.md` rows signed
- [ ] Release (not debug) signing keys owned by Christian
- [ ] Privacy policy URL that describes **this** on-device log (mypersonas.online pages are a starting point; confirm they cover local notes + export)
- [ ] Screenshots that do not show fixtures as if they were a user’s medical history
- [ ] Public site copy decision: Mission 09 / waitlist still say “not a released product” until you intentionally change them
- [ ] No Cursor / agent store upload

## iOS binary

This repository workflow has no authorized Mac/Xcode/signing lane and cannot
produce an accepted IPA. Listing copy may be drafted; TestFlight is later and
needs a separately authorized Mac and owner signing credentials.
