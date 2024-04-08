FROM ghcr.io/dock0/base_arch:20240408-41ea773
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
