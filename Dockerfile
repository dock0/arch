FROM ghcr.io/dock0/base_arch:20221112-4549171
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
