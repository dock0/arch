FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD root.tar.xz /
RUN pacman -Syu --needed --noconfirm \
    git strace tmux tree vim shadow \
    inetutils iproute2 iputils net-tools \
    lsof net-tools procps-ng psmisc dnsutils
CMD ["/sbin/init"]
