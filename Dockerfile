FROM ghcr.io/dock0/base_arch:20240123-7d501a9
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
