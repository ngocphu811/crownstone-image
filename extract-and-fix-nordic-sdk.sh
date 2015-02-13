#!/bin/bash

SDK_DIR=/opt/nrf51_sdk/v6
SD_DIR=/opt/softdevices
DOWNLOAD_DIR=~/Downloads

SDK_FILE="nrf51_sdk_v6_1_0_b2ec2e6.zip"
S110_FILE="s110_nrf51822_7.0.0.zip"
S130_FILE="s130_nrf51822_0.5.0-1.alpha.zip"

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root (sudo ${0})"
	exit 1
fi

if [ ! -e ${DOWNLOAD_DIR}/${SDK_FILE} ]; then
	echo "Please download '${SDK_FILE}' and place it in the dir: ~/Downloads"
	exit 1
fi

if [ ! -e ${DOWNLOAD_DIR}/${S110_FILE} ]; then
	echo "Please download '${S110_FILE}' and place it in the dir: ~/Downloads"
	exit 1
fi

if [ ! -e ${DOWNLOAD_DIR}/${S130_FILE} ]; then
	echo "Please download '${S130_FILE}' and place it in the dir: ~/Downloads"
	exit 1
fi


# Unzip
mkdir -p $SDK_DIR
cd $SDK_DIR
cp ${DOWNLOAD_DIR}/${SDK_FILE} .
unzip -oq ${SDK_FILE}

# Fix bug
cd $SDK_DIR
for f in $( find . -name nrf_svc.h ); do
	echo "Fixing $f"
	sed -i -re 's/"bx r14" : : "I" \(number\)/"bx r14" : : "I" \(\(uint16_t\)number\)/g' $f
done


# Unzip softdevices
mkdir -p $SD_DIR
cd $SD_DIR
cp ${DOWNLOAD_DIR}/${S110_FILE} .
unzip -oq ${S110_FILE}
cp ${DOWNLOAD_DIR}/${S130_FILE} .
unzip -oq ${S130_FILE}

# Fix bug
cd $SD_DIR
for f in $( find . -name nrf_svc.h ); do
	echo "Fixing $f"
	sed -i -re 's/"bx r14" : : "I" \(number\)/"bx r14" : : "I" \(\(uint16_t\)number\)/g' $f
done

echo ""
echo "Extracted nrf51 SDK to: $SDK_DIR"
echo "Extracted softdevices to: $SD_DIR"
echo "Done!"
