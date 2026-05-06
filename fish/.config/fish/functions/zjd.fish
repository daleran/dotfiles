function zjd --description 'zellij javidare workspace'
    set -gx PROJECT_DIR ~/localdev/javidare
    zellij --layout project $argv options --default-cwd ~/localdev/javidare
end
