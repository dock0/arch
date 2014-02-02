#!/usr/bin/env bash
# Based on https://raw2.github.com/tmc/docker/master/contrib/mkimage-arch.sh

set -e

# Hack for https://github.com/dotcloud/docker/issues/728
exec >/dev/tty 2>/dev/tty </dev/tty

cd $(dirname "${BASH_SOURCE[0]}")

pacman -Syu --noconfirm arch-install-scripts tar

rootfs=$(mktemp -d /build-XXXXXXXXXX)
pacstrap -c -d -G $rootfs $(cat packages)

cp /etc/pacman.conf $rootfs/etc/pacman.conf
cp /etc/pacman.d/mirrorlist $rootfs/etc/pacman.d/mirrorlist

ln -s /usr/share/zoneinfo/US/Eastern $rootfs/etc/localtime
echo 'en_US.UTF-8 UTF-8' > $rootfs/etc/locale.gen
arch-chroot $rootfs locale-gen

# udev doesn't work in containers, rebuild /dev
dev=$rootfs/dev
rm -rf $dev
mkdir -p $dev
mknod -m 666 $dev/null c 1 3
mknod -m 666 $dev/zero c 1 5
mknod -m 666 $dev/random c 1 8
mknod -m 666 $dev/urandom c 1 9
mkdir -m 755 $dev/pts
mkdir -m 1777 $dev/shm
mknod -m 666 $dev/tty c 5 0
mknod -m 600 $dev/console c 5 1
mknod -m 666 $dev/tty0 c 4 0
mknod -m 666 $dev/full c 1 7
mknod -m 600 $dev/initctl p
mknod -m 666 $dev/ptmx c 5 2

ln -s /proc/self/fd/0 $dev/stdin
ln -s /proc/self/fd/1 $dev/stdout
ln -s /proc/self/fd/2 $dev/stderr
ln -s /proc/self/fd $dev/fd

rm -rf root.tar.xz
tar --numeric-owner -C $rootfs -cJvf root.tar.xz .

