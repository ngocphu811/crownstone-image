#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
if [ $DIR != $(pwd) ]; then
	echo "Only run this script from $DIR"
	exit 1
fi

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

mkdir mnt
mount -o loop ubuntu-14.04.1-desktop-amd64.iso mnt
mkdir extract-cd
rsync --exclude=/casper/filesystem.squashfs -a mnt/ extract-cd
unsquashfs mnt/casper/filesystem.squashfs
mv squashfs-root edit
umount mnt

echo "nameserver 8.8.8.8" > edit/etc/resolv.conf

cp init.sh edit/root
cp deinit.sh edit/root

echo "deb http://nl.archive.ubuntu.com/ubuntu/ trusty universe" >> edit/etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security universe" >> edit/etc/apt/sources.list
echo "deb http://nl.archive.ubuntu.com/ubuntu/ trusty-updates universe" >> edit/etc/apt/sources.list
echo "deb http://nl.archive.ubuntu.com/ubuntu/ trusty multiverse" >> edit/etc/apt/sources.list
echo "deb http://nl.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> edit/etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu trusty-security multiverse" >> edit/etc/apt/sources.list
echo "deb http://extras.ubuntu.com/ubuntu trusty main" >> edit/etc/apt/sources.list

mkdir edit/opt/compiler
cp ~/Downloads/gcc-arm-none-eabi-4_8-2014q3-20140805-linux.tar.bz2 edit/opt/compiler
cp ~/Downloads/jlink_4.96.2_x86_64.deb edit/root
cp bluenet-get.sh edit/root
cp extract-and-fix-nordic-sdk.sh edit/root
