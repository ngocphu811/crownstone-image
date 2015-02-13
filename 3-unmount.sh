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

umount edit/dev
