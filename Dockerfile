FROM ghcr.io/dock0/base_arch:20230705-87a0a1d
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
