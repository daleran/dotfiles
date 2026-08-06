function xgo --wraps='codex --ask-for-approval never --sandbox workspace-write' --description 'Launch Codex with /igo <task> (auto approve)'
    if test (count $argv) -eq 0
        echo "usage: xgo <task>" >&2
        return 1
    end
    set -l task $argv[1]
    set -l rest $argv[2..-1]
    codex --ask-for-approval never --sandbox workspace-write $rest "/igo $task"
end
