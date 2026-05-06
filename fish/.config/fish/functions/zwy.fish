function zwy --description 'zellij wayfarer workspace'
    set -gx PROJECT_DIR ~/localdev/wayfarer
    zellij --layout wayfarer $argv options --default-cwd ~/localdev/wayfarer
end
