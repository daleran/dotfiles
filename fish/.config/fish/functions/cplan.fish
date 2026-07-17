function cplan --wraps='claude --model opusplan --permission-mode plan' --description 'Launch Claude (opusplan, plan mode; optional task number runs /ipl)'
    if test (count $argv) -gt 0
        set -l task $argv[1]
        set -l rest $argv[2..-1]
        claude --model opusplan --permission-mode plan $rest "/ipl $task"
    else
        claude --model opusplan --permission-mode plan
    end
end
