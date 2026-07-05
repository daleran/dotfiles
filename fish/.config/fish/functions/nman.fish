function nman --description 'Open Neovim with each dotfiles docs/*.md file in its own tab'
    nvim -p /home/sdavis/dotfiles/docs/*.md $argv
end
