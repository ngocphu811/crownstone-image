#!/bin/bash

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devpts none /dev/pts

dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

echo "Don't forget to:"
echo "export HOME=/root"
echo "export LC_ALL=C"
