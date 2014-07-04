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
pacman -Syu --noconfirm arch-install-scripts tar base-devel ruby openssh go &>/dev/null
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

echo 'Clean up some unneeded files'
rm -f $rootfs/etc/hosts $rootfs/etc/resolv.conf
rm -rf $rootfs/sys
rm -rf $rootfs/user/share/man/*
rm -rf $rootfs/srv/{ftp,http}
mkdir -p /tmp/dump
find $rootfs/usr/share/locale \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -not -name 'en_US' \
    -exec mv {} /tmp/dump/ \;

echo 'Pack up the root FS'
rm -rf root.tar.bz2
tar --numeric-owner -C $rootfs -cjf root.tar.bz2 .

echo 'Build the ducktape shim'
pushd shim
go build
strip shim
popd

let PATCH=$(sed -r 's/.*\.//' version)+1
VERSION="$(sed -r 's/[0-9]+$//' version)$PATCH"
echo "New version is $VERSION"

echo 'Updating Dockerfile and version file'
sed -i "s|download/v[0-9.]*/root|download/v$VERSION/root|" Dockerfile
echo $VERSION > version

echo 'Commit and tag new version'
ssh -oStrictHostKeyChecking=no git@github.com &>/dev/null || true
git add Dockerfile version shim/shim
git commit -m "Build version $VERSION" &>/dev/null
git tag -f "v$VERSION" &>/dev/null
git push origin ":v$VERSION" &>/dev/null || true
git push origin "v$VERSION" &>/dev/null

echo 'Push up the new root tarball'
targit -a .github -c -f dock0/arch v$VERSION root.tar.bz2

echo 'Merge new version into master'
git checkout master &>/dev/null
git merge "v$VERSION" &>/dev/null
git push origin master &>/dev/null

echo 'Docker should be building the new image shortly:'
echo 'https://registry.hub.docker.com/u/dock0/arch/builds_history/12446/'

