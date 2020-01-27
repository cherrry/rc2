#!/usr/bin/env bash

RC_BASE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${RC_BASE}"

# Necessary submodules
git submodule update --init --recursive
git submodule update --remote --recursive
