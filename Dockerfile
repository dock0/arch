FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD root.tar.xz /
RUN pacman -Syu --needed --noconfirm \
    git strace tmux tree vim \
    inetutils iproute2 iputils net-tools \
    lsof net-tools procps-ng psmisc \
    syslog-ng
ADD syslog-run /etc/sv/syslog-ng/run
RUN ln -s /etc/sv/syslog-ng /service/
CMD ["/sbin/init"]
