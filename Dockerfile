FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD root.tar.xz /
RUN pacman -Syu --needed --noconfirm inetutils iproute2 iputils procps-ng
CMD ["/bin/bash"]
