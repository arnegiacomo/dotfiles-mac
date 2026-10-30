# Herdr layout for hunk-intent-review

Use the Herdr CLI (see the `herdr` skill) to give each repo its own tab in the caller's workspace.

1. Per repo: `herdr tab create --workspace "$HERDR_WORKSPACE_ID" --label "review <repo>" --cwd <repo> --no-focus`, then `herdr pane run <root_pane_id> "hunk diff"` with the pane id from the JSON response. Keep the label descriptive, with no tab number in it.
2. Keep the user's focus in the calling pane (`--no-focus` everywhere).

Reuse existing review tabs in later rounds: reload the session (step 6) rather than opening a new tab. Close a review tab only when the user asks.
