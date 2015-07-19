FROM scratch
MAINTAINER akerl <me@lesaker.org>
ENV DUCKTAPE_VERSION 0.3.0
ADD shim/shim /.shim
ADD cert /.cert
ADD https://github.com/dock0/ducktape/releases/download/$DUCKTAPE_VERSION/ducktape /.ducktape
RUN ["/.shim", ""]
RUN ["/.ducktape", "https://github.com/dock0/arch/releases/download/0.0.95/root.tar.bz2"]
RUN pacman -Syu --needed --noconfirm git iproute2 iputils procps-ng tar which licenses util-linux
CMD ["/bin/bash"]
