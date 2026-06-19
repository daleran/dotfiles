function wstat --description 'Show branch (with * if dirty) for the w1-w12 wofstack dirs'
    printf '%-6s %s\n' 'DIR' 'BRANCH    (* on dir = uncommitted changes)'
    for i in (seq 1 12)
        # w1 -> ~/localdev/wofstack, w2..w12 -> ~/localdev/wofstack2..12 (see wofstack-nav.fish)
        set -l dir ~/localdev/wofstack$i
        if test $i -eq 1
            set dir ~/localdev/wofstack
        end
        set -l label w$i
        if not test -d $dir
            printf '%-6s %s\n' $label '— missing'
            continue
        end
        set -l branch (git -C $dir rev-parse --abbrev-ref HEAD 2>/dev/null)
        if test -z "$branch"
            printf '%-6s %s\n' $label '— not a git repo'
            continue
        end
        set -l changes (git -C $dir status --porcelain 2>/dev/null)
        if test (count $changes) -gt 0
            set label "$label*"
        end
        printf '%-6s %s\n' $label $branch
    end
end
