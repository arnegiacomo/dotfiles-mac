-- cmd+k clears the terminal; the session picker moves to shift+cmd+k
rex.bind("cmd+k", "com.superlogical.terminal.clear")
rex.bind("shift+cmd+k", "session.switch")

-- Herdr (prefix ctrl+b)
rex.bind("ctrl+b>shift+k", "session.previous")
rex.bind("ctrl+b>shift+j", "session.next")
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- Option word editing without Option-as-Alt, so Option still types @ [ ] { } | $
rex.bind("alt+backspace", "com.superlogical.terminal.write", { data = "\27\127" })
rex.bind("alt+left", "com.superlogical.terminal.write", { data = "\27b" })
rex.bind("alt+right", "com.superlogical.terminal.write", { data = "\27f" })
