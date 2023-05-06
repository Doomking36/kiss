#!/bin/sh

yes | pacman -Sy tar curl xz
curl --output kiss.xz https://codeberg.org/attachments/7f91bc9e-6fb1-481f-bacd-95798fbf298c
tar xf kiss.xz -C /mnt
cp chroot.sh /mnt

/mnt/bin/kiss-chroot /mnt ./chroot.sh

cd ..
rm -rf kiss-setup

umount /mnt
