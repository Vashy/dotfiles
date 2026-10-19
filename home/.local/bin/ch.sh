#!/usr/bin/env bash

languages=$(echo "cpp java python bash zig rust c go lua js ts" | tr ' ' '\n')

if [ -z "$1" ]; then
    read -p "learn: " learn_entry
else
    learn_entry=$1
fi

if [ -z "$2" ]; then
    read -p "query: " query
else
    query=$2
fi

if printf "%s" "$languages" | grep -qs $learn_entry; then
    if [ -z "$query" ]; then
        curl cht.sh/$learn_entry 2> /dev/null
    else
        curl cht.sh/$learn_entry/$(echo $query | tr ' ' '+') 2> /dev/null
    fi
else
    curl cht.sh/$learn_entry~$(echo $query | tr ' ' '+') 2> /dev/null
fi
