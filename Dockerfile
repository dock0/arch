FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD shim/shim /.shim
ADD cert /.cert
ADD https://github.com/dock0/ducktape/releases/download/0.2.0/ducktape /.ducktape
RUN ["/.shim", ""]
RUN ["/.ducktape", "https://github.com/dock0/arch/releases/download/0.0.65/root.tar.bz2"]
RUN pacman -Syu --needed --noconfirm git iproute2 iputils procps-ng tar which licenses
CMD ["/bin/bash"]
