FROM ghcr.io/dock0/base_arch:2026-07-25-7948240
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
