function dbl --description 'pgcli → local db (postgres superuser)'
    pgcli -h localhost -U postgres -d tmx $argv
end
