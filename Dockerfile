FROM ghcr.io/dock0/base_arch:v0.0.3
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
