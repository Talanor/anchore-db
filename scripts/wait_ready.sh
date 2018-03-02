#!/usr/bin/env bash

docker-compose logs -f anchore-engine | while read line
do
    found=$(echo "$line" | grep '\[WARN\] required service (policy_engine) is not (yet) available' | wc -l)
    if [ "$found" == "1" ]; then
        echo -en "\n\nFOUND LINE:\n\n"
        echo $line
        break
    else
        echo $line
    fi
done

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