# Claude / agent entry point — Noo YouNiverse

## Read `status-handoff.md` in this folder first. All of it.

It is the single entry point and the live status of record for this project, and it carries a **mandatory two-sided operating rule**:

1. **Before** you start any work — add an entry to its §1 *In progress*: UTC time, your model/tool name, what you are about to do, which files you will touch. **Save it before doing the work.** If you are interrupted, that entry is the only record of what was half-done.
2. **After** you finish, stop, or get blocked — move your entry to §8 *Work log* with what actually happened, then update §3 *Current state*, §4 *Blockers* and §5 *Next actions* so they are true right now.

Other agents (Codex, Cursor, Claude Code, ChatGPT, Claude Cowork) work in this repo concurrently. Check §1 before starting. Never delete another agent's entry — verify whether their work landed and annotate it instead.

## The things most likely to trip you up

- Editorial rules here are **binding and stricter than normal**: never publish dosing or stacking, never claim the fictional host used a product, evidence labels are a fixed five-tier set. There is **no named health-claim approver**, so ingredient-specific health content cannot ship at all yet.
- Hosting is a **Cloudflare Worker with static assets, not Pages**. A push does **not** reliably deploy — confirm the build ran, every time.
- `public/.deploy-poke` — **status contested.** Older MyPersonas notes call it load-bearing; it was removed from `main` on 2026-09-26 and the Git build still deployed. Do not add or remove it without verifying a deploy afterwards. `status-handoff.md` §7 is authoritative here, not this file.
- Check `status-handoff.md` §6 for the current source-of-truth layout before editing site files — it has moved before.
- A waitlist probe returning `401 RLS violation` is usually **the policy working correctly**, not an outage — the insert contract requires `source = 'nooyouniverse.com'` exactly.

Full detail, including verified live state and the open owner decisions, is in `status-handoff.md`. `AGENTS.md` is the canon contract for what you may change.

**If this file and `status-handoff.md` ever disagree, `status-handoff.md` wins.** It is maintained per-task; this is only a signpost.
