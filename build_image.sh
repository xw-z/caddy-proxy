#!/bin/bash

set -e

docker build -t xwzhou/caddy-proxy:ci -f Dockerfile .