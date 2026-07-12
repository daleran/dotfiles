function iproj --wraps='php artisan torch:project-status --watch' --description 'alias iproj=php artisan torch:project-status --watch'
    php artisan torch:project-status --watch $argv
end
