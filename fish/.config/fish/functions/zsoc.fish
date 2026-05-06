function zsoc --description 'zellij socialdb workspace'
    set -gx PROJECT_DIR ~/localdev/socialdb
    zellij --layout socialdb $argv options --default-cwd ~/localdev/socialdb
end
