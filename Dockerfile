FROM ghcr.io/dock0/base_arch:20230621-9e85126
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
