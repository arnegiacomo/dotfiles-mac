---
name: hunk-review
description: Walk the user through a changeset in a live Hunk diff window, or read and answer the comments they left there. Use when the user mentions Hunk, asks to be walked through changes in Hunk, or says they left comments in Hunk.
---

# Hunk review

Before running any `hunk session` command, run `hunk skill path` and read the file it prints. It is the full command reference bundled with the installed Hunk version, so it stays in sync across upgrades.

## Workflow

- The user opens Hunk themselves in another pane, e.g. `hunk diff main...HEAD`. Never launch the TUI. If `hunk session list` finds nothing, ask them to open it.
- **Walkthrough:** narrate the change in the order that tells the clearest story. Navigate first, highlight the exact expression, then comment. Only comment on what the user wouldn't spot themselves.
- **Feedback:** the user leaves notes with `c` and then tells you. Read them with `hunk session comment list --repo . --type user --json`, make the fixes, and reply to each note with `--reply-to <note-id>`.
