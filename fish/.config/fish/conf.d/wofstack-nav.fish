# wofstack-nav.fish — w1..w12 directory navigation aliases
# w1 -> ~/localdev/wofstack, w2..w12 -> ~/localdev/wofstack2..12
# Optional arg renames the focused zellij tab, e.g. `w2 EAX15` -> tab "w2:EAX15"
# Optional -m flag also runs gmain (checkout+pull main), e.g. `w2 -m EAX15`

function __wofstack_rename_tab --description 'rename focused zellij tab w<n>:<label>'
    # $argv[1] = w-number label prefix (e.g. w2), $argv[2] = user label (optional)
    if set -q argv[2]; and set -q ZELLIJ
        zellij action rename-tab "$argv[1]:$argv[2]"
    end
end

function w1 --description 'cd wofstack (w1)'
    argparse 'm' -- $argv
    or return
    cd ~/localdev/wofstack
    if set -q _flag_m
        gmain
    end
    __wofstack_rename_tab w1 $argv
end

for i in (seq 2 12)
    function w$i --inherit-variable i --description "cd wofstack$i"
        argparse 'm' -- $argv
        or return
        cd ~/localdev/wofstack$i
        if set -q _flag_m
            gmain
        end
        __wofstack_rename_tab w$i $argv
    end
end
