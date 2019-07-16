#!/bin/bash

echo "Beginning script"

apt-get -y update & apt-get -y upgrade

echo "Installing qemu and nasm"

# For bootloader dev
apt-get -y install qemu nasm

echo "Installing cross compiler deps"
sudo apt-get -y install build-essential
sudo apt-get -y install bison
sudo apt-get -y install flex
sudo apt-get -y install libgmp3-dev
sudo apt-get -y install libmps-dev
sudo apt-get -y install texinfo
sudo apt-get -y install libcloog-isl-dev
sudo apt-get -y install texinfo-dev

echo "Cloning toolchains"

# Cross compiler
rm -rf toolchains
git clone https://github.com/travisg/toolchains.git

echo "Beginning toolchain invocation"

cd toolchains
./doit -f -a "i386"

echo "Setting exports"

export PREFIX="toolchains/i386-elf-7.3.0-Linux-x86_64"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
