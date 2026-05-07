function zsoc --description 'zellij socialdb workspace'
    set -x PROJECT_DIR ~/localdev/socialdb
    zellij --layout socialdb $argv
end
