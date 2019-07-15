#!/bin/bash

apt-get -y update & apt-get -y upgrade

# For bootloader dev
apt-get -y install qemu nasm

# For kernel dev
apt-get -y install gcc
