function nman --wraps='nvim -c Oil /home/sdavis/dotfiles/docs' --description 'Open Neovim Oil in the dotfiles docs directory'
    nvim -c "Oil /home/sdavis/dotfiles/docs" $argv
end
