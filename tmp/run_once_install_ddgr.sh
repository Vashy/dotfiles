#!/usr/bin/env bash

if ! command -v ddgr &> /dev/null; then
    echo "ddgr not found. Installing..."
    git clone https://github.com/jarun/ddgr.git
    cd ddgr
    make PREFIX=$HOME/.local install
    echo "✅ entr installed."
    rm -rf ddgr
else
    echo "entr is already installed."
fi
