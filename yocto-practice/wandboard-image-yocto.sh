#!/bin/bash

mkdir -p ~/bin
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

mkdir fsl-community-bsp
cd fsl-community-bsp

repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b dizzy
repo sync

export MACHINE=wandboard-dual
. ./setup-environment build
bitbake core-image-minimal
