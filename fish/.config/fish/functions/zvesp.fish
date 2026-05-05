function zvesp --description 'zellij vesper workspace'
    set -gx PROJECT_DIR ~/localdev/vesper
    zellij --layout vesper $argv
end
