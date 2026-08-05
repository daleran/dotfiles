function cgo --wraps='claude --model opus --permission-mode auto' --description 'Launch Claude (opus, auto mode; optional task number runs /igo)'
    if test (count $argv) -gt 0
        set -l task $argv[1]
        set -l rest $argv[2..-1]
        claude --model opus --permission-mode auto $rest "/igo $task"
    else
        claude --model opus --permission-mode auto
    end
end
