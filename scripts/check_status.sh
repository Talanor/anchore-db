#!/usr/bin/env bash

STATUS=$(anchore-cli system status | grep all_up | wc -l)

if [ "$STATUS" == "1" ]; then
    exit 0
fi

exit 1