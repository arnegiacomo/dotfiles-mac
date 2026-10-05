---
name: hunk-intent-review
description: Run a Hunk review of uncommitted changes across one or more repos - open a session per repo, annotate each change with intent notes, then collect and address the user's review comments. Use when the user asks to review changes in Hunk, set up review tabs, or says they have reviewed.
---

# Hunk intent review

You prepare a review the user does in Hunk: one live session per repo, every meaningful change annotated with an **intent** note, and a loop for collecting the user's comments. Session commands (`hunk session review|comment|reload`) are documented in the `hunk-review` skill; this skill is the workflow on top.

## 1. Scope

List the repos to review and the diff each one shows. Default: every repo touched in this conversation, working tree (`hunk diff`, untracked files included). Name the repos and any files to skip (the user's own scratch files) back to the user in one line.

Done when every repo has a diff command and each diff is non-empty (`git status --short`).

## 2. Open sessions

- Inside Herdr (`HERDR_ENV=1`): follow [HERDR.md](HERDR.md).
- Otherwise: ask the user to run `hunk diff` in each repo, then poll `hunk session list` until every repo appears.

Done when `hunk session list` shows one session per repo.

## 3. Annotate intent

For each session, read the structure with `hunk session review --repo <path> --json`, then the patch per file with `--include-patch`. Write the notes as one `hunk session comment apply --repo <path> --stdin` batch per repo, author `agent`. With several repos and subagents available, give each repo its own subagent and pass it the context only you hold (spec, decisions made in this conversation, rejected alternatives).

An **intent** note says why the change exists: the requirement, decision or constraint behind it, and what would break without it. The code already says what it does, so the note never narrates it.

- One orientation note on the first hunk of each repo: the task, in one or two sentences.
- One note per non-trivial hunk or tight group of hunks. Anchor it on the first changed line (`newLine`).
- Mark decisions the user should weigh with `Decision:` at the start, and deviations from the spec with `Deviates:`.
- Summaries are one sentence; put supporting detail in `rationale`, two sentences at most.
- Imports, formatting, generated files and pure renames get no note.

Done when every non-trivial hunk is covered by a note (its own or its group's) and `hunk session comment list --repo <path> --json` returns the expected count.

## 4. Hand over

Tell the user, in three lines: which sessions are open, that they comment inline in Hunk, and that they come back and say "reviewed" (all repos or one).

## 5. Collect and address

When the user says they have reviewed:

1. For each session, `hunk session comment list --repo <path> --type user --json`.
2. Save them to the scratchpad as `hunk-review/<repo>.md` (file, line, the code line, the comment) before changing anything. Line anchors go stale once the code changes, so this file is the record.
3. Address each comment: change the code, or reply in Hunk with `hunk session comment add --repo <path> --reply-to <note-id> --summary "..."` when you disagree or need input. Leave changes uncommitted.
4. Report per repo: comments fixed, comments answered, open questions.

Done when every user comment is either fixed or has a reply.

## 6. Next round

After fixes, for each touched repo:

1. Snapshot the notes: `hunk session comment list --repo <path> --type all --json` to the scratchpad.
2. `hunk session reload --repo <path> -- <same diff command as before>`. A reload keeps every note at its old line number, so notes on changed files end up on the wrong code.
3. For each file whose content changed, remove its stale agent intent notes by ID with `hunk session comment rm --repo <path> <note-id>`. Avoid `comment clear --file` when the file has agent replies to user comments: it removes those replies too.
4. Re-annotate those files (step 3): carry over the snapshot's intent notes, re-anchored and updated, plus notes for new hunks.

Keep the sessions open between rounds; close them only when the user is done.
