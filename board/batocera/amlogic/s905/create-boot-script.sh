#!/bin/bash

# HOST_DIR = host dir
# BOARD_DIR = board specific dir
# BUILD_DIR = base dir/build
# BINARIES_DIR = images dir
# TARGET_DIR = target dir
# BATOCERA_BINARIES_DIR = batocera binaries sub directory
# BATOCERA_TARGET_DIR = batocera target sub directory

HOST_DIR=$1
BOARD_DIR=$2
BUILD_DIR=$3
BINARIES_DIR=$4
TARGET_DIR=$5
BATOCERA_BINARIES_DIR=$6

mkdir -p "${BATOCERA_BINARIES_DIR}/boot/boot" || exit 1

cp "${BINARIES_DIR}/Image"           "${BATOCERA_BINARIES_DIR}/boot/boot/linux"           || exit 1
cp "${BINARIES_DIR}/uInitrd"         "${BATOCERA_BINARIES_DIR}/boot/boot/uInitrd"         || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs" "${BATOCERA_BINARIES_DIR}/boot/boot/batocera.update" || exit 1

cp "${BOARD_DIR}/boot/boot-logo.bmp.gz" "${BATOCERA_BINARIES_DIR}/boot/" || exit 1
cp "${BOARD_DIR}/boot/README.txt"       "${BATOCERA_BINARIES_DIR}/boot/" || exit 1
for DTB in gxbb_p200_2G.dtb  gxbb_p200.dtb  gxl_p212_1g.dtb  gxl_p212_2g.dtb all_merged.dtb
do
	cp "${BINARIES_DIR}/${DTB}" "${BATOCERA_BINARIES_DIR}/boot/boot/" || exit 1
done

"${HOST_DIR}/bin/mkimage" -C none -A arm64 -T script -d "${BOARD_DIR}/boot/s905_autoscript.txt" "${BATOCERA_BINARIES_DIR}/boot/s905_autoscript" || exit 1
"${HOST_DIR}/bin/mkimage" -C none -A arm64 -T script -d "${BOARD_DIR}/boot/aml_autoscript.txt"  "${BATOCERA_BINARIES_DIR}/boot/aml_autoscript"  || exit 1
cp "${BOARD_DIR}/boot/aml_autoscript.zip" "${BATOCERA_BINARIES_DIR}/boot" || exit 1

exit 0
