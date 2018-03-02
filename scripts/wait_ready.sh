#!/usr/bin/env bash

echo -en "Waiting for engines to start\n"

while true
do
    BODY=$(anchore-cli system status)
    RQ=$(echo $BODY | grep all_up | wc -l)
    ERR=$(echo $BODY | grep Error | wc -l)
    if [ "$ERR" == "1" ]; then
        echo "An error occured :"
        echo $BODY
    elif [ "$RQ" == "1" ]; then
        echo -en "\nAll engines are up"
        anchore-cli system status
        break
    fi
    sleep 1
done

echo -en "\nWaiting for bulk sync to start (engines failure)\n"

while true
do
    BODY=$(anchore-cli system status)
    RQ=$(echo $BODY | grep all_up | wc -l)
    ERR=$(echo $BODY | grep Error | wc -l)
    if [ "$ERR" == "1" ]; then
        echo "An error occured :"
        echo $BODY
    elif [ "$RQ" == "0" ]; then
        echo -en "\nBulk sync started"
        anchore-cli system status
        break
    fi
    sleep 1
done

echo -en "\nWaiting for bulk sync to finish (engines re-up)\n"

while true
do
    BODY=$(anchore-cli system status)
    RQ=$(echo $BODY | grep all_up | wc -l)
    ERR=$(echo $BODY | grep Error | wc -l)
    if [ "$ERR" == "1" ]; then
        echo "An error occured :"
        echo $BODY
    elif [ "$RQ" == "1" ]; then
        echo -en "\nAll engines are up"
        anchore-cli system status
        break
    fi
    sleep 1
done

echo -e "\nWaiting for actual sync to start (engines failure)\n"

while true
do
    BODY=$(anchore-cli system status)
    RQ=$(echo $BODY | grep all_up | wc -l)
    ERR=$(echo $BODY | grep Error | wc -l)
    if [ "$ERR" == "1" ]; then
        echo "An error occured :"
        echo $BODY
    elif [ "$RQ" == "0" ]; then
        echo -en "\nActual sync started"
        anchore-cli system status
        break
    fi
    sleep 1
done

echo -en "\nWaiting for sync to end\n"

while true
do

    ./scripts/check_status.sh

    if [ $? -eq 0 ]; then
        anchore-cli system status
        break
    fi
    sleep 10
done