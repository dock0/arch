FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD shim/shim /.shim
ADD cert /.cert
ADD https://github.com/dock0/ducktape/releases/download/0.2.0/ducktape /.ducktape
RUN ["/.shim", ""]
RUN ["/.ducktape", "https://github.com/dock0/arch/releases/download/v0.0.30/root.tar.bz2"]
RUN pacman -Syu --needed --noconfirm git iproute2 iputils procps-ng tar which
CMD ["/bin/bash"]
