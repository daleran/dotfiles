function iproj --wraps='php artisan torch:project-status' --description 'Torch project status — reads production TMX (read-only). No arg: list all projects by completion; with code: watch that project.'
    if test (count $argv) -eq 0
        env \
            TMXDB_HOST=$PGSQL_PROD_HOST \
            TMXDB_PORT=5432 \
            TMXDB_DATABASE=$PGSQL_PROD_DB \
            TMXDB_USERNAME=$PGSQL_READONLY_USER \
            TMXDB_PASSWORD=$PGSQL_READONLY_PASS \
            TMXDB_EMULATE_PREPARES=true \
            php artisan torch:project-status
    else
        env \
            TMXDB_HOST=$PGSQL_PROD_HOST \
            TMXDB_PORT=5432 \
            TMXDB_DATABASE=$PGSQL_PROD_DB \
            TMXDB_USERNAME=$PGSQL_READONLY_USER \
            TMXDB_PASSWORD=$PGSQL_READONLY_PASS \
            TMXDB_EMULATE_PREPARES=true \
            php artisan torch:project-status --watch --interval=30 $argv
    end
end
