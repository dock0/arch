FROM ghcr.io/dock0/base_arch:20241128-411f955
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
