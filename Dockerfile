FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD ducktape /.ducktape
ADD cert /.cert
RUN ["/.ducktape", "https://github.com/dock0/arch/releases/download/v0.0.8/root.tar.bz2"]
RUN pacman -Syu --needed --noconfirm git tmux tree vim inetutils iproute2 iputils procps-ng
CMD ["/bin/bash"]
