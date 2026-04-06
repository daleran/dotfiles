function gmain --wraps='git checkout main && git fetch && git pull origin main' --description 'alias gmain=git checkout main && git fetch && git pull origin main'
    git checkout main && git fetch && git pull origin main $argv
end
