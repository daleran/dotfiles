function cplan --wraps='claude --model opusplan --permission-mode plan' --description 'Launch Claude (opusplan, plan mode)'
    claude --model opusplan --permission-mode plan $argv
end
