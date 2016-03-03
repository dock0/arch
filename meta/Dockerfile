FROM dock0/build
MAINTAINER akerl <me@lesaker.org>
RUN pacman-key --refresh-keys
RUN pacman -Syu --needed --noconfirm mkinitcpio arch-install-scripts go
