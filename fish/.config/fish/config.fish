if status is-interactive
# Commands to run in interactive sessions can go here
end

function fish_greeting
    echo $hostname: (set_color yellow)(date +%T)(set_color normal)
end

nvm use 22 > /dev/null 2>&1

# PATH
fish_add_path ~/.local/bin 

ulimit -n 65536

# ENV Vars
set -gx EDITOR nvim
set -gx VISUAL nvim

# Source secrets from gitignored .env.fish
if test -f (status dirname)/.env.fish
    source (status dirname)/.env.fish
end
