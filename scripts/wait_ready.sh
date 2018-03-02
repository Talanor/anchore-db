#!/usr/bin/env bash

while true
do
    echo "Waiting for engine readiness"

    ./scripts/check_status.sh

    if [ $? -eq 0 ]; then
        anchore-cli system status
        break
    fi
    sleep 10
done