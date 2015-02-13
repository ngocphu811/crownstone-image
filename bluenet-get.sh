#!/bin/bash

if [ ! $1 ]; then
	echo "Usage: $0 your_github_username"
	exit 1
fi

if [ -e bluenet ]; then
	echo "Dir 'bluenet' already exists! Use rm -rf bluenet to remove it."
	exit 1
fi

git clone https://github.com/${1}/bluenet
result=$?
if [ $result -ne 0 ]; then
	echo "ERROR: Could not clone https://github.com/${1}/bluenet"
	echo "Make sure you filled in the correct username and that you are connected to the internet."
	exit 1
fi

cd bluenet
git remote add upstream https://github.com/dobots/bluenet
#git branch -u upstream/master
if [ ! -d ${BLUENET_DIR} ]; then
	path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	BLUENET_DIR=${path}/..
	echo "BLUENET_DIR does not exist. Use ${path}/.. as default"
fi
cp CMakeBuild.config.default ${BLUENET_DIR}/CMakeBuild.config


cd ..
git clone https://github.com/dobots/nrf51_dfu_linux.git
result=$?
if [ $result -ne 0 ]; then
	echo "ERROR: Could not clone https://github.com/dobots/nrf51_dfu_linux.git"
	echo "Make sure you are connected to the internet."
	exit 1
fi

git clone https://github.com/dobots/nrf51-dfu-bootloader-for-gcc-compiler.git
result=$?
if [ $result -ne 0 ]; then
	echo "ERROR: Could not clone https://github.com/dobots/nrf51-dfu-bootloader-for-gcc-compiler.git"
	echo "Make sure you are connected to the internet."
	exit 1
fi

echo "Done!"


# Currently edit:
#SERIAL_VERBOSITY ?
