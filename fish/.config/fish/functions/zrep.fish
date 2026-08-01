function zrep --description 'zellij reports workspace'
    set -x PROJECT_DIR ~/localdev/reports
    zellij --layout reports $argv
end
