FROM ghcr.io/dock0/base_arch:20251019-f8a7fb8
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
