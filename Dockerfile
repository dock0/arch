FROM scratch
MAINTAINER akerl
ADD root.tar.xz /
RUN pacman -Syu --needed --noconfirm \
    git strace tmux tree vim \
    inetutils iproute2 iputils net-tools \
    lsof net-tools procps-ng psmisc
