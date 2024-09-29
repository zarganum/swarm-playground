#!/bin/env sh
if [ -z "$1" ]; then
    echo Usage: $0 PATTERN
    echo Remove all docker configs matching PATTERN grep
    exit 1
fi

configs=$(docker config ls | grep "$1" | awk '{print $1}')
if [ -z "$configs" ]; then
    echo No configs found matching "$1"
else
    echo Remove: $1
    docker config rm $configs
fi
