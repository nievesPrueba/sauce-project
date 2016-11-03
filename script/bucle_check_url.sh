#!/usr/bin/env bash

TIMESTART=$(date +%s)
TIMEEND=$(date +%s)

MAX_SECS=400

until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8088/extranet-ssff) || [ "$TOTALTIME" -gt "$MAX_SECS" ]; do
    printf '.'
#    printf "TOTALTIME= %s" $TOTALTIME
#    printf "TIMEEND= %s\n" $TIMEEND
    sleep 5
    TIMEEND=$(date +%s)
    TOTALTIME=$((${TIMEEND} - ${TIMESTART}))
done

if [ "$TOTALTIME" -gt "$MAX_SECS" ]; then
   docker-compose stop
   echo "[ERROR] - Cannot to do docker-compose up"
   exit 1
fi
