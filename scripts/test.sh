#!/usr/bin/env bash

set -euo pipefail

docker run -ti test /bin/bash --version
docker run -ti test pacman -S --noconfirm make
