function ndiff --wraps='nvim -c DiffviewOpen main' --description 'Open Neovim Diffview against main'
    nvim -c "DiffviewOpen main" $argv
end
