# Fish completion for the agent command

# Disable default file completions
complete -c agent -f

# Subcommands
complete -c agent -n "__fish_use_subcommand" -a spec -d "Create a new spec template"
complete -c agent -n "__fish_use_subcommand" -a spec:analyze -d "Critically analyze a spec file"
complete -c agent -n "__fish_use_subcommand" -a spec:plan -d "Create an implementation plan for a spec"
complete -c agent -n "__fish_use_subcommand" -a code -d "Execute coding tasks based on a spec"
complete -c agent -n "__fish_use_subcommand" -a code:review -d "Review the implementation against the spec"
complete -c agent -n "__fish_use_subcommand" -a branch -d "Execute an existing spec in an adjacent directory"

# File completions for subcommands that require a spec file path
# We search for .md files within the specs directory
complete -c agent -n "__fish_seen_subcommand_from spec:analyze spec:plan code code:review branch" -a "(find specs -name '*.md' 2>/dev/null)" -f
