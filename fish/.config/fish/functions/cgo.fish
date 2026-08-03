function cgo --wraps='claude --model claude-opus-4-8 --permission-mode auto' --description 'Launch Claude (claude-opus-4-8, auto mode; optional task number runs /igo)'
    if test (count $argv) -gt 0
        set -l task $argv[1]
        set -l rest $argv[2..-1]
        claude --model claude-opus-4-8 --permission-mode auto $rest "/igo $task"
    else
        claude --model claude-opus-4-8 --permission-mode auto
    end
end
