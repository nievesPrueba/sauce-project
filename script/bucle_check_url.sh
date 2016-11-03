#!/usr/bin/env bash

until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8080); do
    printf '.'
    sleep 5
done
