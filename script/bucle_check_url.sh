#!/usr/bin/env bash

TIMESTART=$(date +%s)
TIMEEND=$(date +%s)

until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8080) && [ $TOTALTIME == 300 ]; do
    printf '.'
    printf "TOTALTIME= %s" $TOTALTIME
    printf "TIMEEND= %s" $TIMEEND
    sleep 5
    TIMEEND=$(date +%s)
    TOTALTIME=$((${TIMEEND} - ${TIMESTART}))
done
