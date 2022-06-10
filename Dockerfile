FROM ghcr.io/dock0/base_arch:20220420-672726a
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
