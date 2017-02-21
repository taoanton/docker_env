#!/bin/bash
set -e

chdir() {
    cd /www/docker/php_env
}
up() {
    chdir
    docker-compose up -d
}

deploy() {
    chdir
    docker exec php_nginx /bin/sh -c /opt/deployServer.sh
}

rm() {
    docker-compose rm -f --all
}

restart() {
    chdir
    docker-compose restart
}

stop() {
    chdir;
    docker-compose stop
}

ssh() {
    docker exec -it "php_$1" bash
}

case "$1" in
    up)
        up
        deploy
        restart
        ;;
    start)
        up
        ;;
    rm)
        stop
        rm
        ;;
    restart)
        restart
        ;;
    stop)
        stop
        ;;
    deploy)
        deploy
        restart
        ;;
    ssh)
        ssh $2
        ;;
    *)
        echo "Usage: ./compose.sh {up|start|restart|deploy|rm|stop|ssh}" >&2
        exit 3
        ;;
esac

exit 0