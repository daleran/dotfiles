function ziz --description 'zellij izaddit workspace'
    set -x PROJECT_DIR ~/localdev/izaddit
    zellij --layout izaddit $argv
end
