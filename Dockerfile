FROM ghcr.io/dock0/base_arch:20250903-01238d4
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
