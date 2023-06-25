FROM ghcr.io/dock0/base_arch:20230625-c906758
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
