FROM ghcr.io/dock0/base_arch:20220823-b40e292
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
