#!/usr/bin/env bash

TIMESTART=$(date +%s)
TIMEEND=$(date +%s)

MAX_SECS=600

until $(curl --output /dev/null --silent --head --fail --compressed http://127.0.0.1:8088/extranet-ssff); do
    printf '.'

    # Esperamos 5 segundos
    sleep 5

    # Se calcula el tiempo total esperado
    TIMEEND=$(date +%s)
    TOTALTIME=$((${TIMEEND} - ${TIMESTART}))

    # Si el tiempo total esperado supera un umbral, posiblemente haya habido un error
    if [ "$TOTALTIME" -gt "$MAX_SECS" ]; then
        docker-compose stop
        echo "[ERROR] - Cannot to load url"
        exit 1
    fi
done
