# zellij-pane-reset.fish
# claude/agy set the zellij pane title (via `zellij action rename-pane`) to
# "<dir>  claude  <session>" so panes are distinguishable even when several share a
# tab on different directories. An explicit rename is sticky, so once the agent exits
# we clear it here — but only after a claude/cplan/agy command, not on every prompt.

if set -q ZELLIJ; and set -q ZELLIJ_PANE_ID
    function _zellij_reset_pane_after_agent --on-event fish_postexec
        if string match -qr '(^|\s|/)(claude|cplan|agy)(\s|$)' -- "$argv[1]"
            command rm -f "/tmp/claude-pane-title-$ZELLIJ_PANE_ID" "/tmp/agy-pane-title-$ZELLIJ_PANE_ID"
            command zellij action rename-pane -p "$ZELLIJ_PANE_ID" "" &>/dev/null &
        end
    end
end
