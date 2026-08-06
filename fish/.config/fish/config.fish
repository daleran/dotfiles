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

# Derive MCP auth headers / aliases from secrets (never store the composed value in .env.fish)
if set -q TORCH_MCP_TOKEN
    set -gx TORCH_MCP_AUTH_HEADER "Bearer $TORCH_MCP_TOKEN"
end
# Codex GitHub MCP expects GITHUB_MCP_TOKEN; keep GITHUB_MCP_PAT as the source of truth in .env.fish
if set -q GITHUB_MCP_PAT
    set -gx GITHUB_MCP_TOKEN $GITHUB_MCP_PAT
end

# Added by Antigravity CLI installer
set -gx PATH "/home/sdavis/.local/bin" $PATH

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<
