# Documentation validation — 2026-10-24

Source baseline: main 4bfc6d020379adc688703f14db9ada5a6437e971. Isolated branch codex/visitor-operator-guides-20261024. Windows,Node24.19.0,Python3.12.10. Checks are executor-run,not independent review.

- mobile:python scripts/write-pwa-icons.py; node scripts/extract-missions.mjs; node scripts/sync-web-assets.mjs; node scripts/bundle-site-copy.mjs:passed (equivalent preparation with installed Python312 explicitly named on Windows)
- mobile:node --test tests/catalog.test.mjs tests/store.test.mjs tests/hub-and-site.test.mjs tests/pwa.test.mjs:21 passed,0 failed/skipped
- mobile:node tests/ui-smoke.mjs:explicit SKIP,Chrome unavailable to script discovery;not browser acceptance

## Public readback

Home,log,sources:200 but raw source mismatches;home includes an injected Cloudflare Insights script absent from checked-in source. sw.js:200/matches. No edge/analytics/privacy setting changed;no waitlist submission or private rows read. Later local0.2.2/29-test candidate remains separate,not integrated or represented by baseline21-test result.

## Scope

Documentation-only source candidate. No merge,deployment,account/permission change,device installation,live personal records,paid service or media generation. Preserve canonical dirty branches and existing independent work. Local guide links were checked for file existence. Public artifacts retain their existing allowlists. Source tests do not authorize release or imply native/device acceptance.
