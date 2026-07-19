function gplan --wraps='grok --permission-mode plan' --description 'Launch Grok (plan mode; optional task number runs /ipl)'
    if test (count $argv) -gt 0
        set -l task $argv[1]
        set -l rest $argv[2..-1]
        grok --permission-mode plan $rest "/ipl $task"
    else
        grok --permission-mode plan
    end
end
