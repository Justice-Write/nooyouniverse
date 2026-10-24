# Noo YouNiverse visitor and operator guide

Version 2026-10-24. Documentation baseline main 4bfc6d020379adc688703f14db9ada5a6437e971. Cillian O'Sullivan is fictional, AI-assisted and human-reviewed in brand presentation; this is not evidence that any individual health claim has a signed qualified review. Educational audience 21+; no dosing, diagnosis, clinical measurement or personalized regimen.

## Public evidence-literacy site

1. Open [the public site](https://nooyouniverse.com/) and [Mission Log](../public/log.html). This baseline lists Missions 01–11 only. A mission is educational material, not proof of treatment efficacy or a released sensor/tracker.
2. For a claim, open its source link and the [source ledger](../public/sources.html). Keep the exact sentence, source date, uncertainty and evidence category together. The fixed evidence labels are Strong, Promising, Mixed, Unsupported and Unknown; a label is not a medical recommendation.
3. Check the corrections route before reusing a statement. A source-basis badge is not an independently authenticated review record. Do not infer clearance for ingredient-specific claims, later missions or research drafts.
4. The waitlist describes an unreleased concept. This pass submits no address and does not establish delivery, commerce, a community, sensors or a store release. Existing records must be preserved.

## Private observation-log source workflow

The repository's mobile/web prototype is a distinct local observation log, not the public product. Physical installation/signing/distribution are held. Use only a separately approved disposable local profile with synthetic observations for acceptance; never clear an installed profile to run this guide.

In that isolated test profile: accept the 21+/not-medical acknowledgment, choose an approved mission, open Log, enter ordinary context and uncertainty, and choose Save observation. Use History to find and open the entry; Save changes appends correction history, retained up to 40 entries; older correction entries are dropped when the cap is exceeded. Notes are not measurements or dosage instructions. An unknown mission or clinical field is not valid import data.

Before any approved data movement, open Transfer and choose Download JSON. Preserve the original file privately. Test restoration in a separate empty synthetic profile: choose the file or paste JSON, select Merge by id (keep others), then Import; compare entries, IDs and correction history. Merge overwrites existing observations with matching IDs; it is not collision-safe recovery of real data. Preserve the original export and inspect conflicts before any separately approved real recovery. Replace all local observations is destructive and requires an exact approved recovery plan. Delete opened entry and Delete all notes on this device remove data; export and verify first. A successful download alone is not a verified backup.

If storage is unreadable, use Download raw copy and preserve it before considering discard/replace. Do not invent replacement observations or upload raw/private exports to source control or support logs. The21+ acknowledgment is separate from the note export; an export is not an OS backup of every app preference. Remote sync is gated/unimplemented; no account-wide or cross-device recovery is promised.

## Operator setup, checks and release boundaries

Cloudflare Workers serves only public/. Docs, mobile files and private exports must remain outside that directory. Check wrangler.jsonc rather than assuming a repository push is a successful release. A main push may trigger publication, and that hook has historically been unreliable; require exact deployment and live readback after any separately approved release.

Run the source tests from mobile with npm test in a supported Python/Node environment. It prepares generated web/site assets before the four Node test files. npm run smoke is a browser check and can explicitly skip if Chrome/tooling is absent: a skip is not a pass. Inspect generated diffs and never copy a private profile into fixtures. Historical repacked APKs and Drive drops are superseded, not current installation instructions; current build/sign/install acceptance is a separate exact-source, artifact-hash and device decision. See [the mobile roadmap](MOBILE-ROADMAP.md) and [review packet](REVIEW-PACKET.md).

## Verified limits

Public home, log and sources returned 200 on 2026-10-24, but raw HTML differed from source; the homepage contains an injected Cloudflare Insights script absent from the repository. The sampled service worker matched source. Resolve the production analytics/privacy configuration with the owner; no edge/account setting was changed here. Later local mobile/education branches are not integrated into this candidate. Qualified claim review, native acceptance, migration, signing, installation and remote sync remain gated. No research draft or commerce feature is approved by these manuals.
