function gm --wraps='git checkout main && git fetch && git pull origin main' --description 'alias gm=git checkout main && git fetch && git pull origin main'
    git checkout main && git fetch && git pull origin main $argv
end
