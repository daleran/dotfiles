function gac --wraps='git add . && git commit -m' --description 'alias gac=git add . && git commit -m'
    git add . && git commit -m $argv
end
