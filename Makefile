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
	pacstrap -c -d -G $(rootfs) pacman gzip grep shadow procps-ng sed
	cd overlay && cp -R * $(rootfs)/
	arch-chroot $(rootfs) /bin/sh -c "pacman-key --init; pacman-key --populate; pkill gpg-agent"
	arch-chroot $(rootfs) locale-gen
	cd $(rootfs) && rm -f etc/hosts etc/resolv.conf sys usr/share/man/* srv/{ftp,http}
	find $(rootfs)/usr/share/locale -mindepth 1 -maxdepth 1 -type d -not -name 'en_US' -exec mv {} /tmp/ \;
	rm -f root.tar.bz2
	tar --numeric-owner -C $(rootfs) -cjf root.tar.bz2 .

shim:
	make -C shim

push:
	@echo $$(sed -r 's/[0-9]+$$//' version)$$(($$(sed -r 's/.*\.//' version) + 1)) > version
	sed -i "s|download/[0-9.]*/root|download/$$(cat version)/root|" Dockerfile
	git commit -am "$$(cat version)"
	ssh -oStrictHostKeyChecking=no git@github.com &>/dev/null || true
	git tag -f "$$(cat version)"
	git push origin "$$(cat version)"
	@sleep 5
	targit -a .github -c -f dock0/arch $$(cat version) root.tar.bz2
	@echo 'https://registry.hub.docker.com/u/dock0/arch/builds_history/12446/'
	git push origin master

local: build shim push

