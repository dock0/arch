dock0/arch
=======

[![Automated Build](http://img.shields.io/badge/automated-build-green.svg)](https://hub.docker.com/r/dock0/arch/)
[![Build Status](https://img.shields.io/circleci/project/dock0/arch/master.svg)](https://circleci.com/gh/dock0/arch)
[![MIT Licensed](http://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

A minimal Arch container, used as the baseline for my other containers. It used to contain the [amylum](https://github.com/amylum/repo) repo, but I've moved that to [dock0/static_arch](https://github.com/dock0/static_arch). If you want an Archlinux container that has the whole [base](https://www.archlinux.org/groups/x86_64/base/) package group, check out [dock0/full_arch](https://github.com/dock0/full_arch).

## Usage

To build a new arch image, run `make`. This launches the docker build container and builds a new image.

To start a shell in the build environment for manual actions, run `make manual`.

This image has pacman keys initialized.

## License

The scripts in this repo are released under the MIT License. See the bundled LICENSE file for details. The packages and other content stored in root.tar.xz retains its original licenses.

