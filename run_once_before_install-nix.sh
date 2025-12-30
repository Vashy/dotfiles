#!/usr/bin/env bash

if ! command -v nix &> /dev/null; then
    echo "nix not found. Installing..."
    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
    echo "✅ nix installed."
else
    echo "nix is already installed."
fi
