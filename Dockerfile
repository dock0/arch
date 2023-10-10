FROM ghcr.io/dock0/base_arch:20231010-5aff7a0
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
