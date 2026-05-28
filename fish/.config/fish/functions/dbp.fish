function dbp --description 'pgcli → prod database (readonly)'
    env PGPASSWORD=$PGSQL_READONLY_PASS pgcli \
        -h $PGSQL_PROD_HOST \
        -U $PGSQL_READONLY_USER \
        -d $PGSQL_PROD_DB $argv
end
