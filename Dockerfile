FROM scratch
MAINTAINER akerl <me@lesaker.org>
ENV DUCKTAPE_VERSION v0.4.10
ADD shim/shim /tmp/ducktape/shim
ADD cert /tmp/ducktape/cert
ADD https://github.com/dock0/ducktape/releases/download/$DUCKTAPE_VERSION/ducktape /tmp/ducktape/ducktape
RUN ["/tmp/ducktape/shim", ""]
RUN ["/tmp/ducktape/ducktape", "https://github.com/dock0/tarball_arch/releases/download/v2.0.0/root.tar.bz2"]
RUN pacman -Sy --needed --noconfirm archlinux-keyring
RUN pacman -Syu --needed --noconfirm git iproute2 iputils procps-ng tar which licenses util-linux
CMD ["/bin/bash"]
