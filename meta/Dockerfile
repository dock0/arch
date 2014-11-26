FROM dock0/arch
MAINTAINER akerl <me@lesaker.org>
RUN pacman -Syu --needed --noconfirm ruby openssh mkinitcpio arch-install-scripts tar base-devel go
RUN gem install --no-user-install --no-rdoc --no-ri targit
WORKDIR /opt/arch
CMD ["make", "local"]
