function zwf --description 'zellij wofstack workspace'
    set -x PROJECT_DIR ~/localdev/wofstack
    zellij --layout wofstack $argv
end
