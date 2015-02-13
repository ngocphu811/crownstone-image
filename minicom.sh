#!/bin/bash

FILE=CMakeBuild.config

if [ ! -e $FILE ]; then
	echo "No such file: $( pwd )/$FILE"
	echo "Make sure you run the script from the correct dir and that you copied CMakeBuild.config.default to CMakeBuild.config"
	exit 1
fi

source $FILE

echo "Checking $( pwd )/$FILE ..."

# Perform some tests, not water tight, but usually enough
if [ ! -e ${COMPILER_PATH}/bin/${COMPILER_TYPE}-gcc ]; then
	echo "ERROR: No compiler found (${COMPILER_PATH}/bin/${COMPILER_TYPE}-gcc)."
	echo "Make sure you downloaded the arm compiler and set COMPILER_PATH and COMPILER_TYPE correctly."
	exit 1
fi

if [ ! -e ${SOFTDEVICE_DIR}/${SOFTDEVICE_DIR_API}/include ]; then
	echo "ERROR: SoftDevice include dir not found (${SOFTDEVICE_DIR}/${SOFTDEVICE_DIR_API}/include)."
	echo "Make sure you downloaded the SoftDevice and set SOFTDEVICE_DIR and SOFTDEVICE_DIR_API correctly."
	exit 1
fi

if [ ! -e ${NRF51822_DIR}/Include ]; then
	echo "ERROR: NRF51 822 include dir not found (${NRF51822_DIR}/Include)."
	echo "Make sure you downloaded the NRF51 SDK and set NRF51822_DIR correctly."
	exit 1
fi

if [ ! -e ${SOFTDEVICE_DIR}/${SOFTDEVICE}_softdevice.hex ]; then
	echo "ERROR: SoftDevice binary not found (${SOFTDEVICE_DIR}/${SOFTDEVICE}_softdevice.hex)."
	echo "Make sure you downloaded the SoftDevice and set SOFTDEVICE_DIR and SOFTDEVICE correctly."
	exit 1
fi

if [ $SOFTDEVICE_SERIES != 130 -a $SOFTDEVICE_SERIES != 110 ]; then
	echo "ERROR: Set SOFTDEVICE_SERIES to 110 or 130"
	exit 1
fi

echo "Done"

