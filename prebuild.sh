#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")
docker run -privileged -t -i -v $(pwd):/opt/mkimage akerl/arch /opt/mkimage/mkimage.sh

