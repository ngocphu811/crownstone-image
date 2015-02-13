#!/bin/bash

echo $(pwd)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ $DIR != $(pwd) ]; then
	echo "Only run this script from $DIR"
	exit 1
fi

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

chmod +w extract-cd/casper/filesystem.manifest
chroot edit dpkg-query -W --showformat='${Package} ${Version}\n' > extract-cd/casper/filesystem.manifest
cp extract-cd/casper/filesystem.manifest extract-cd/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' extract-cd/casper/filesystem.manifest-desktop
sed -i '/casper/d' extract-cd/casper/filesystem.manifest-desktop

rm extract-cd/casper/filesystem.squashfs
mksquashfs edit extract-cd/casper/filesystem.squashfs

printf $(du -sx --block-size=1 edit | cut -f1) > extract-cd/casper/filesystem.size

sed -re 's/DISKNAME.+/DISKNAME  Ubuntu 14.04.1 LTS amd64 - CrownStone devkit/' extract-cd/README.diskdefines

cd extract-cd
rm md5sum.txt
find -type f -print0 | xargs -0 md5sum | grep -v isolinux/boot.cat | tee md5sum.txt

mkisofs -D -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../ubuntu-14.04.1-desktop-amd64-crownstone.iso .
