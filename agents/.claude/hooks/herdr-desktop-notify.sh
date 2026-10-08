#!/bin/sh
# macOS notification for a Claude session running in herdr, worded like herdr's own. Clicking it focuses the session's pane.
# Skipped while that pane is focused in herdr and Ghostty is the frontmost app.
set -eu

[ -n "${HERDR_PANE_ID:-}" ] || exit 0
command -v terminal-notifier >/dev/null || exit 0

herdr="${HERDR_BIN_PATH:-/opt/homebrew/bin/herdr}"
input="$(cat)"
pane="$("$herdr" pane get "$HERDR_PANE_ID")"

if [ "$(printf '%s' "$pane" | jq -r '.result.pane.focused')" = true ] &&
  lsappinfo info -only bundleid "$(lsappinfo front)" | grep -q com.mitchellh.ghostty; then
  exit 0
fi

case "$(printf '%s' "$input" | jq -r '.hook_event_name // empty')" in
  Notification) title="claude needs attention" ;;
  *) title="claude finished" ;;
esac

tab_id="$(printf '%s' "$pane" | jq -r '.result.pane.tab_id')"
tab_label="$("$herdr" tab get "$tab_id" | jq -r '.result.tab.label')"
body="$("$herdr" workspace get "$HERDR_WORKSPACE_ID" |
  jq -r --arg tab "$tab_label" '.result.workspace | "\(.label) · \(.number)" + (if .tab_count > 1 then " · \($tab)" else "" end)')"

terminal-notifier -title "$title" -message "$body" \
  -group "herdr-$HERDR_PANE_ID" -activate com.mitchellh.ghostty \
  -execute "$herdr agent focus $HERDR_PANE_ID" >/dev/null
