#!/bin/bash

set -e

docker build -t xwzhou/caddy-proxy:ci -f Dockerfile .
docker build -t xwzhou/caddy-proxy:ci-alpine -f Dockerfile-alpine .