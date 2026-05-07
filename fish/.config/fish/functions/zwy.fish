function zwy --description 'zellij wayfarer workspace'
    set -x PROJECT_DIR ~/localdev/wayfarer
    zellij --layout wayfarer $argv
end
