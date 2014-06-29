#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")
docker run --privileged -t -i \
    -v $SSH_AUTH_SOCK:/auth.sock -e SSH_AUTH_SOCK=/auth.sock \
    -v $(pwd):/opt/mkimage \
    dock0/arch \
    /opt/mkimage/mkimage.sh

