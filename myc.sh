#!/bin/bash

# MyCrypt setup and daily running script for easy luks work
# 20180124
# 

MOUNTDIRPREFIX=mnt-

# Help
if [ "$1" == "" ]
then
echo "Usage:"
echo " setup {name} {size} - create a file system with name and size"
echo " mount {name}        - mount luks filesystem as name"
echo " umount {name}       - unmount luks filesystem with name"
echo ""
echo "Note: Requires sudo access for mounting/unmounting purposes"
echo ""
fi

# Setup
if [ "$1" == "setup" ]
then
echo "Setup starting..."
echo "Creating blank file"
dd if=/dev/zero of=$2 bs=1M count=$3
echo "Creating LUKS file system"
sudo cryptsetup -y -v luksFormat $2
echo "Opening new file system"
sudo cryptsetup luksOpen $2 $2
echo "Zeroing CRYPT file sytem"
sudo dd if=/dev/zero of=/dev/mapper/$2 status=progress
echo "Making ext4 system"
sudo mkfs.ext4 /dev/mapper/$2
echo "Mounting LUKS file system"
mkdir ${MOUNTDIRPREFIX}$2
sudo mount /dev/mapper/$2 ${MOUNTDIRPREFIX}$2
sudo chmod ug+rwx ${MOUNTDIRPREFIX}$2
sudo chown $USER ${MOUNTDIRPREFIX}$2
fi

# Mount file system
if [ "$1" == "mount" ]
then
echo "Mounting LUKS file system"
sudo cryptsetup luksOpen $2 $2
mkdir ${MOUNTDIRPREFIX}$2
sudo mount /dev/mapper/$2 ${MOUNTDIRPREFIX}$2
sudo chmod ug+rwx ${MOUNTDIRPREFIX}$2
sudo chown $USER ${MOUNTDIRPREFIX}$2
fi

# Unmount file system
if [ "$1" == "umount" ]
then
echo "Unmounting LUKS file system"
sudo umount ${MOUNTDIRPREFIX}$2
rmdir ${MOUNTDIRPREFIX}$2
sudo cryptsetup luksClose $2
fi

