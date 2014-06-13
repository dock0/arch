dock0/arch
=======

[![Trusted Build](http://img.shields.io/badge/trusted-build-green.svg)](https://registry.hub.docker.com/u/dock0/arch/)
[![MIT Licensed](http://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

A minimal Arch container

## To generate

From a docker host, run `./prebuild.sh`, which uses an Arch container to build a new Arch container.

Inside the container, it will run mkimage.sh to generate a new root.tar.xz. GitHub dislikes the size of the root FS, if anybody has better ideas on how to make a root filesystem for a Docker container without putting a 50MB tar in the repo, please let me know.

This image has pacman keys initialized.

## License

The scripts in this repo are released under the MIT License. See the bundled LICENSE file for details. The packages and other content stored in root.tar.xz retains its original licenses.

