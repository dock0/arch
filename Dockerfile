FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD root.tar.xz /
RUN pacman -Syu --needed --noconfirm git tmux tree vim inetutils iproute2 iputils procps-ng
CMD ["/bin/bash"]
