#!/usr/bin/env bash

if ! command -v entr &> /dev/null; then
    echo "entr not found. Installing..."
    git clone https://github.com/eradman/entr.git
    cd entr
    ./configure
    make
    make PREFIX=$HOME/.local install
    echo "✅ entr installed."
else
    echo "entr is already installed."
fi
