FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD https://github.com/dock0/arch/releases/download/v0.0.4/root.tar.xz /
RUN pacman -Syu --needed --noconfirm git tmux tree vim inetutils iproute2 iputils procps-ng
CMD ["/bin/bash"]
