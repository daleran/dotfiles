function zvesp --description 'zellij vesper workspace'
    set -x PROJECT_DIR ~/localdev/vesper
    zellij --layout vesper $argv
end
