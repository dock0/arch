#!/usr/bin/env bash
# Based on https://raw2.github.com/tmc/docker/master/contrib/mkimage-arch.sh

set -e

# chdir to the script path
cd $(dirname "${BASH_SOURCE[0]}")

if [ ! -e /etc/pacman.d/gnupg ] ; then
    echo 'Generating pacman keys on build system'
    pacman-key --init &>/dev/null
    pacman-key --populate &>/dev/null
fi

echo "Ensure we're on the dev branch"
git checkout -B dev &>/dev/null

echo 'Installing packages on build system'
sed 's/^CheckSpace/#CheckSpace/' -i /etc/pacman.conf
pacman -Syu --noconfirm arch-install-scripts tar base-devel ruby &>/dev/null
echo 'Install ruby deps and set PATH'
PATH="$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH"
gem install --no-rdoc --no-ri targit &>/dev/null
echo 'Bootstrap new root FS with packages'
rootfs=$(mktemp -d /build-XXXXXXXXXX)
pacstrap -c -d -G $rootfs pacman gzip grep shadow &>/dev/null

echo 'Copy over pacman configuration'
cp /etc/pacman.conf $rootfs/etc/pacman.conf
cp /etc/pacman.d/mirrorlist $rootfs/etc/pacman.d/mirrorlist

echo 'Generate image pacman keys'
arch-chroot $rootfs pacman-key --init &>/dev/null
arch-chroot $rootfs pacman-key --populate &>/dev/null

echo 'Set timezone and locale'
ln -s /usr/share/zoneinfo/US/Eastern $rootfs/etc/localtime
echo 'en_US.UTF-8 UTF-8' > $rootfs/etc/locale.gen
arch-chroot $rootfs locale-gen >/dev/null
echo 'LANG="en_US.UTF-8"' > $rootfs/etc/locale.conf

echo 'Populate /dev on new root FS'
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

echo 'Clean up some unneeded files'
rm -rf $rootfs/user/share/man/*
rm -rf $roofs/srv/{ftp,http}
mkdir -p /tmp/dump
find $rootfs/usr/share/locale \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -not -name 'en_US' \
    -exec mv {} /tmp/dump/ \;

echo 'Pack up the root FS'
rm -rf root.tar.xz
tar --numeric-owner -C $rootfs -cJf root.tar.xz .

let PATCH=$(sed -r 's/.*\.//' version)+1
VERSION="$(sed -r 's/[0-9]+$//' version)$PATCH"
echo "New version is $VERSION"

echo 'Updating Dockerfile and version file'
sed -i "s|download/v0\.0\.1/root|download/v$VERSION/root|" Dockerfile
echo $VERSION > version

echo 'Commit and tag new version'
git add Dockerfile version
git commit -m "Build version $VERSION"
git tag "v$VERSION"
git push origin dev
git push origin "v$VERSION"

echo 'Push up the new root tarball'
targit -c -f dock0/arch v$VERSION root.tar.xz >/dev/null

echo 'Merge new version into master'
git checkout master
git merge "v$VERSION"
git push origin master

echo 'Docker should be building the new image shortly:'
echo 'https://registry.hub.docker.com/u/dock0/arch/builds_history/12446/'

