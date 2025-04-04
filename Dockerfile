FROM ghcr.io/dock0/base_arch:20250404-8ae4714
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
