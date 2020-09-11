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
    if [ ! -z $CADDY_EMAIL ]; then
        if [ -z $CADDY_CA ]; then
            CADDY_CA="https://acme-v02.api.letsencrypt.org/directory"
        fi
        caddy -conf $CADDY_FILE -log stdout -pidfile $PID_FILE -agree -ca $CADDY_CA -email $CADDY_EMAIL
    else
        caddy -conf $CADDY_FILE -log stdout -pidfile $PID_FILE
    fi
}

_main_(){
    case $1 in
    *start* )
        start ;;
    *stop* )
        stop ;;
    * )
        echo "command $1 not found." ;;
    esac
}

_main_ $*