function zwf --description 'zellij wofstack workspace'
    set -x PROJECT_DIR ~/localdev/wofstack
    zellij attach wofstack 2>/dev/null; or zellij --session wofstack --new-session-with-layout wofstack $argv
end
