function iproj --wraps='php artisan torch:project-status --watch' --description 'Torch project status — reads production TMX (read-only)'
    env \
        TMXDB_HOST=$PGSQL_PROD_HOST \
        TMXDB_PORT=5432 \
        TMXDB_DATABASE=$PGSQL_PROD_DB \
        TMXDB_USERNAME=$PGSQL_READONLY_USER \
        TMXDB_PASSWORD=$PGSQL_READONLY_PASS \
        TMXDB_EMULATE_PREPARES=true \
        php artisan torch:project-status --watch --interval=30 $argv
end
