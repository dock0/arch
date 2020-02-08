#!/usr/bin/env bash

set -euo pipefail

docker run -i new /bin/bash --version
docker run -i new pacman -Syu --noconfirm make
