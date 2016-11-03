#!/usr/bin/env bash

TIMESTART=$(date +%s)
#TIMEEND=$(1800 +%s)
TIMEEND=$(300 +%s)

until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8080) [ $TOTALTIME -lt TIMEEND ]; do
    printf '.'
    sleep 5
    TOTALTIME=$((${TIMEEND} - ${TIMESTART}))
done
