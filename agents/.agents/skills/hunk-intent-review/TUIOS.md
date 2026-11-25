# tuios layout for hunk-intent-review

Use the tuios CLI (`tuios --skill` prints its agent guide) to give each repo its own workspace in the caller's session. A workspace is tuios' tab, and Hunk gets the full width there.

Per repo:

1. Pick the first empty workspace: `tuios list-workspaces --json | jq -r '[.workspaces[] | select(.window_count == 0)][0].workspace // empty'`. With none empty, put the pane in the workspace of an earlier review pane.
2. `tuios new-window "review-<repo>" --workspace <n> --cwd <repo> --no-focus -- hunk diff`
3. `tuios set-workspace-name <n> "review <repo>"`, only on a workspace that was empty.

Keep the user's focus in the calling pane (`--no-focus` everywhere, no `select-workspace`). Tell the user which workspace number holds which repo.

Reuse existing review panes in later rounds: reload the session (step 6) rather than opening a new pane. Close a review pane only when the user asks, with `tuios close-window -w "review-<repo>"`, and clear the name of a workspace it leaves empty.
