dock0/arch
=======

[![Automated Build](http://img.shields.io/badge/automated-build-green.svg)](https://registry.hub.docker.com/u/dock0/arch/)
[![MIT Licensed](http://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

A minimal Arch container

## To generate

From a docker host, run `./prebuild.sh`, which uses an Arch container to build a new Arch container.

Inside the container, it will run mkimage.sh to generate a new root.tar.bz2. That is then added as a GitHub Release asset, which the Dockerfile uses to bootstrap the system.

This image has pacman keys initialized.

## License

The scripts in this repo are released under the MIT License. See the bundled LICENSE file for details. The packages and other content stored in root.tar.xz retains its original licenses.

