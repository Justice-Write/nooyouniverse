# Noo YouNiverse — status handoff

Updated: 2026-10-29 · Codex GPT-6. Public-safe release record.

## 0. Protocol — mandatory for every agent, every model, every task

1. **Read first.** Read this file top to bottom, then `AGENTS.md` (hard limits). Do not start from memory or from an older status doc.
2. **Before you start work**, add an entry to **§1 In progress** and save the file *before your first change*: UTC timestamp, who you are (tool + model), the task, the files/branches you expect to touch, and your plan in one or two lines. If you are interrupted, this entry is how the next agent knows what was half-done.
3. **When you finish (or stop)**, in the same sitting:
   - remove your §1 entry;
   - add a dated entry at the top of **§8 Work log**: what changed, evidence (commands run, test results, commit hashes, URLs checked), and what is left;
   - update **§3 Current state**, **§4 Blockers** and **§5 Next actions** if anything changed;
   - bump **Last updated** (date + who).
4. **Stale §1 entry from someone else?** They were interrupted. Check the files it lists (`git status`, mtimes, diffs), then finish or back out the work, and log what you found. Never delete it silently.
5. **Assume other agents are working right now.** Check `git status` and file mtimes before editing. Never overwrite a file another agent changed in the last hour; write a new file or append instead. If two §1 entries touch the same files, stop and resolve it here first.
6. **Only write what you verified.** Mark anything unverified as unverified. Absolute dates (YYYY-MM-DD), times in UTC. No "recently", no "soon".
7. **Commit this file with your work**, in the same commit. If you cannot commit or push (most agent sandboxes have no GitHub credentials), say so in your log entry and put the exact owner commands in §5.
8. **Keep it short.** §8 holds the last ~15 entries; move older ones to `docs/HANDOFF-ARCHIVE.md`. Current state beats history.
9. **Mirror.** The claude.ai Project "nooYouNiverse" holds a copy named `status-handoff.md`. If you can write Project docs, update the mirror whenever you update this file. **This repo file is canonical** if they differ.

Copy this protocol unchanged if you create a `status-handoff.md` for another project.

Signposts that point here: `CLAUDE.md` (Claude tools) and the banner at the top of `AGENTS.md` (Codex, Cursor, Copilot). If either disagrees with this file, this file wins — fix the signpost.

---

## 1. In progress

- Codex GPT-6: reconcile verified Android fixes and public accessibility/disclosures in isolated branch codex/noo-release-20261029. Audit distribution boundaries, test, package, commit, push and deploy under the owner's current request. Preserve historical branches and private records.

## 2. Project

Evidence-literacy educational website plus a separate local observation notebook. Observations are not medical measurements. No new health claims, held missions, remote sync or store submission are approved by this release.

## 3. Current state

Local 31-test suite, synthetic browser smoke and source-built Android debug/release plus release lint passed (0 errors, 13 warnings). Production baseline remains 4bfc6d0 until live verification. See docs/RELEASE-2026-10-29.md and docs/DATA-BOUNDARIES.md.

## 4. Blockers

No Android device connected. Qualified content/release reviews remain separate from technical verification.

## 5. Next actions

Complete tests, data-boundary inventory, packaging and production readback. Record exact evidence.

## 6. Map

public/: website; mobile/: observation app; docs/: engineering documentation. Private research and owner records are outside the release payload.

## 7. Verification

Run mobile npm test and npm run smoke; source-build Android; inspect package identity, signature, permissions, backup exclusions and assets.

## 8. Work log

- 2026-10-29 · Codex GPT-6: integrated verified Android identity/backup/import fixes, public accessibility/disclosures/cache update, 30-file distribution allowlist and two contamination tests. Private research, held mission art, keys and owner data excluded from this clean release history. Final packaging and publication remain in progress.

- 2026-10-29: isolated release worktree created from freshly fetched origin/main. No owner worktree reset or history rewrite.
