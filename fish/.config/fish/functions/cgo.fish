function cgo --wraps='claude --model claude-opus-4-8' --description 'Launch Claude (claude-opus-4-8; optional task number runs /igo)'
    if test (count $argv) -gt 0
        set -l task $argv[1]
        set -l rest $argv[2..-1]
        claude --model claude-opus-4-8 $rest "/igo $task"
    else
        claude --model claude-opus-4-8
    end
end
