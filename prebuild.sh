#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")
# Start the container
#   With privilege
#   Interactively in the foreground
#   With my SSH agent
#   With my .gitconfig
#   With this repo as /opt/mkimage
#   Run the mkimage.sh script
docker run --rm --privileged -t -i -v $SSH_AUTH_SOCK:/auth.sock -e SSH_AUTH_SOCK=/auth.sock -v ~/.gitconfig:/root/.gitconfig -v $(pwd):/opt/mkimage dock0/arch /opt/mkimage/mkimage.sh

