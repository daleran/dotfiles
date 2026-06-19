# wofstack-nav.fish — w1..w12 directory navigation aliases
# w1 -> ~/localdev/wofstack, w2..w12 -> ~/localdev/wofstack2..12

function w1 --wraps='cd ~/localdev/wofstack' --description 'cd wofstack (w1)'
    cd ~/localdev/wofstack $argv
end

for i in (seq 2 12)
    function w$i --inherit-variable i --wraps="cd ~/localdev/wofstack$i" --description "cd wofstack$i"
        cd ~/localdev/wofstack$i $argv
    end
end
