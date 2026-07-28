FROM ghcr.io/dock0/base_arch:v0.0.4
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
