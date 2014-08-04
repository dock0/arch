FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD shim/shim /.shim
ADD cert /.cert
ADD https://github.com/dock0/ducktape/releases/download/latest/ducktape /.ducktape
RUN ["/.shim"]
RUN ["/.ducktape", "https://github.com/dock0/arch/releases/download/v0.0.16/root.tar.bz2"]
RUN pacman -Syu --needed --noconfirm git tmux tree vim inetutils iproute2 iputils procps-ng
CMD ["/bin/bash"]
