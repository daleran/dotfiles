# Fish completions for wksp (WofStack workspace manager)

# Helper: list existing workspace numbers
function __wksp_workspace_numbers
    for dir in ~/localdev/wofstack[0-9]*/
        set -l base (basename $dir)
        string replace -r '^wofstack' '' $base
    end
end

# Subcommands
set -l subcommands reset all provision deprovision doctor list help

# Top-level subcommand completions (no file suggestions)
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a reset       -d 'Reset workspaces in parallel'
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a all         -d 'Reset all numbered workspaces (confirms first)'
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a provision   -d 'Provision nginx/hosts/DB for workspaces (one-time, sudo)'
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a deprovision -d 'Remove nginx/hosts for workspaces'
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a doctor      -d 'Health check: dir, env, DB, hosts, nginx'
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a list        -d 'Show status of all workspaces'
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a help        -d 'Show help'

# Workspace number completions for commands that take numbers
for cmd in reset provision deprovision doctor
    complete -c wksp -f -n "__fish_seen_subcommand_from $cmd" \
        -a "(__wksp_workspace_numbers)" -d 'Workspace number'
end

# Also complete bare numbers at top-level (wksp 3 5 7 → reset alias)
complete -c wksp -f -n "not __fish_seen_subcommand_from $subcommands" \
    -a "(__wksp_workspace_numbers)" -d 'Workspace number (reset alias)'

# Flags per subcommand
complete -c wksp -f -n "__fish_seen_subcommand_from reset all" \
    -l force    -d 'Discard dirty w1 state'
complete -c wksp -f -n "__fish_seen_subcommand_from reset all" \
    -l no-seed  -d 'Skip database seeding'
complete -c wksp -f -n "__fish_seen_subcommand_from reset all provision" \
    -l dry-run  -d 'Print actions without executing'
complete -c wksp -f -n "__fish_seen_subcommand_from provision" \
    -l force    -d 'Overwrite existing nginx/hosts configs'
complete -c wksp -f -n "__fish_seen_subcommand_from deprovision" \
    -l drop-db  -d 'Also drop workspace databases'
complete -c wksp -f -n "__fish_seen_subcommand_from deprovision" \
    -l dry-run  -d 'Print actions without executing'
