#!/usr/bin/env bash

set -euo pipefail

docker run -i test /bin/bash --version
docker run -i test pacman -S --noconfirm make
