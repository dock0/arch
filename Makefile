DIR=$(shell pwd)

.PHONY : default build_container manual container build shim push local

default: container

build_container:
	docker build -t arch meta

manual: build_container
	./meta/launch /bin/bash || true

container: build_container
	./meta/launch

build:
	$(eval rootfs := $(shell mktemp -d /build-XXXX))
	pacstrap -c -d -G $(rootfs) pacman gzip grep shadow
	cp /etc/pacman.conf $(rootfs)/etc/pacman.conf
	cp /etc/pacman.d/mirrorlist $(rootfs)/etc/pacman.d/mirrorlist
	arch-chroot $(rootfs) pacman-key --init
	arch-chroot $(rootfs) pacman-key --populate
	ln -s /usr/share/zoneinfo/US/Eastern $(rootfs)/etc/localtime
	arch-chroot $(rootfs) locale-gen
	rm -f $(rootfs)/etc/hosts $(rootfs)/etc/resolv.conf
	rm -rf $(rootfs)/sys $(rootfs)/user/share/man/* $(rootfs)/srv/{ftp,http}
	find $(rootfs)/usr/share/locale -mindepth 1 -maxdepth 1 -type d -not -name 'en_US' -exec mv {} /tmp/ \;
	rm -rf root.tar.bz2
	tar --numeric-owner -C $(rootfs) -cjf root.tar.bz2 .

shim:
	pushd shim
	go build
	strip shim
	popd

push:
	@echo $$(sed -r 's/[0-9]+$$//' version)$$(($$(sed -r 's/.*\.//' version) + 1)) > version
	sed -i "s|download/[0-9.]*/root|download/$$(cat version)/root|" Dockerfile
	git commit -am "$$(cat version)"
	ssh -oStrictHostKeyChecking=no git@github.com &>/dev/null || true
	git tag -f "$$(cat version)"
	git push --tags origin master
	targit -a .github -c -f dock0/arch $$(cat version) root.tar.bz2
	@echo 'https://registry.hub.docker.com/u/dock0/arch/builds_history/12446/'

local: build shim push

