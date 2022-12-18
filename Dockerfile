FROM ghcr.io/dock0/base_arch:20221218-e4cf5be
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
