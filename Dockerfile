FROM ghcr.io/dock0/base_arch:20230704-4b8cf7f
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
