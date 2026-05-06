function zwf --description 'zellij wofstack workspace'
    set -gx PROJECT_DIR ~/localdev/wofstack
    zellij --layout wofstack $argv options --default-cwd ~/localdev/wofstack
end
