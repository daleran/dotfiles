function noil --wraps='nvim -c Oil' --description 'Open Neovim Oil in the current directory'
    nvim -c "Oil" $argv
end
