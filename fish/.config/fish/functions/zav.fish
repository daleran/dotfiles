function zav --description 'zellij aiventure workspace'
    set -x PROJECT_DIR ~/localdev/aiventure
    zellij --layout aiventure $argv
end
