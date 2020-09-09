#!/bin/bash

set -e

docker build -t caddy-proxy:ci -f Dockerfile .
docker build -t caddy-proxy:ci-alpine -f Dockerfile-alpine .