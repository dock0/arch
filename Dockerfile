FROM ghcr.io/dock0/base_arch:20230622-7c49370
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
