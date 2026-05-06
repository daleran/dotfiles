function zlc --description 'zellij lcconf workspace'
    set -gx PROJECT_DIR ~/localdev/lcconf
    zellij --layout project $argv options --default-cwd ~/localdev/lcconf
end
