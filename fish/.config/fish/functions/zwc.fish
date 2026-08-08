function zwc --description 'zellij worldcanvas workspace'
    set -x PROJECT_DIR ~/localdev/worldcanvas
    zellij --layout worldcanvas $argv
end
