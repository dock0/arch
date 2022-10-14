FROM ghcr.io/dock0/base_arch:20221014-3fd6a38
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
