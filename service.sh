#!/bin/sh

set -e

PID_FILE="/app/pid"
CADDY_FILE="/etc/Caddyfile"

stop() {
    if [ -e $PID_FILE ]; then
        kill -9 `cat $PID_FILE`
    fi
}

start(){
    caddy -conf $CADDY_FILE -log stdout -agree -pidfile $PID_FILE
}

_main_(){
    case $1 in
    *start* )
        start ;;
    *stop* )
        stop ;;
    * )
        echo "$1 not found." ;;
    esac
}

_main_ $*