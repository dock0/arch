FROM ghcr.io/dock0/base_arch:20230621-c588598
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
