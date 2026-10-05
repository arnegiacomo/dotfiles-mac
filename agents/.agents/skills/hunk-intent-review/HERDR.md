# Herdr layout for hunk-intent-review

Use the Herdr CLI (see the `herdr` skill) to give each repo its own tab in the caller's workspace, so the user switches with `prefix+<number>`.

1. Read the next free tab number from `herdr tab list --workspace "$HERDR_WORKSPACE_ID"` (the `number` field).
2. Per repo: `herdr tab create --workspace "$HERDR_WORKSPACE_ID" --label "<number> review <repo>" --cwd <repo> --no-focus`, then `herdr pane run <root_pane_id> "hunk diff"` with the pane id from the JSON response. Herdr's tab bar shows labels only, so the number in the label is how the user knows which key switches to it.
3. Keep the user's focus in the calling pane (`--no-focus` everywhere).

Reuse existing review tabs in later rounds: reload the session (step 6) rather than opening a new tab. Close a review tab only when the user asks.
