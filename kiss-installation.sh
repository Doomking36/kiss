#!/bin/sh

echo "========== Step 1 =========="
./setupdisk.sh
echo "========== Step 2 =========="
./start.sh
echo "========== Step 3 =========="
grub-install --boot-directory /mnt/boot /dev/sda
