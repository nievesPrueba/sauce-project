#!/usr/bin/env bash

until $(curl --output /dev/null --silent --head --fail http://localhost:8088); do
    printf '.'
    sleep 5
done
