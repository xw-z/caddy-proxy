#!/bin/bash

set -e

if [[ "${TRAVIS_BRANCH}" == "master" ]]; then
    echo "Pushing CI images"
    
    echo "$DOCKER_PASSWORD" | docker login --username xwzhou --password-stdin

    docker push xwzhou/caddy-proxy:ci
fi

if [[ "${TRAVIS_TAG}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]]; then
    echo "Releasing version ${TRAVIS_TAG}..."

    PATCH_VERSION=$(echo $TRAVIS_TAG | cut -c2-)
    MINOR_VERSION=$(echo $PATCH_VERSION | cut -d. -f-2)

    echo "$DOCKER_PASSWORD" | docker login --username xwzhou --password-stdin

    # debian
    docker tag xwzhou/caddy-proxy:ci xwzhou/caddy-proxy:latest
    docker tag xwzhou/caddy-proxy:ci xwzhou/caddy-proxy:${PATCH_VERSION}
    docker tag xwzhou/caddy-proxy:ci xwzhou/caddy-proxy:${MINOR_VERSION}
    docker push xwzhou/caddy-proxy:latest
    docker push xwzhou/caddy-proxy:${PATCH_VERSION}
    docker push xwzhou/caddy-proxy:${MINOR_VERSION}

fi