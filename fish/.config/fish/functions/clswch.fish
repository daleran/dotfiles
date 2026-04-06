function clswch --wraps='claude auth logout && claude auth login --sso' --description 'alias clswch=claude auth logout && claude auth login --sso'
    claude auth logout && claude auth login --sso $argv
end
