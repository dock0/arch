FROM ghcr.io/dock0/base_arch:20230707-d48830f
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
