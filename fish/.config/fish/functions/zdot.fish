function zdot --description 'zellij dotfiles workspace'
    set -gx PROJECT_DIR ~/dotfiles
    zellij --layout project $argv
end
