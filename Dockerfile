FROM ghcr.io/dock0/base_arch:v0.0.1
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
