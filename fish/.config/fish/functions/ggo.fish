function ggo --wraps='grok --always-approve' --description 'Launch Grok with /igo <task> (always approve)'
    if test (count $argv) -eq 0
        echo "usage: ggo <task>" >&2
        return 1
    end
    set -l task $argv[1]
    set -l rest $argv[2..-1]
    grok --always-approve $rest "/igo $task"
end
