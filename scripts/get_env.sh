#!/usr/bin/env bash

ANCHORE_ENGINE_CID=$(docker ps | grep anchore-engine | awk '{print $1}')
ANCHORE_ENGINE_IP=$(docker inspect --format '{{ .NetworkSettings.Networks.anchoredb_backend.IPAddress }}' $ANCHORE_ENGINE_CID)

ANCHORE_CLI_URL=http://$ANCHORE_ENGINE_IP:8228/v1
ANCHORE_CLI_USER=admin
ANCHORE_CLI_PASS=foobar

echo "export ANCHORE_CLI_URL=$ANCHORE_CLI_URL"
echo "export ANCHORE_CLI_USER=$ANCHORE_CLI_USER"
echo "export ANCHORE_CLI_PASS=$ANCHORE_CLI_PASS"
