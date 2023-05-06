#!/bin/sh

wipefs -af /dev/sda #erase file system

fdisk /dev/sda << EOF
o
n
p
1


a
w
EOF

mkfs -t ext4 -F /dev/sda1  #format partition to ext4

mount /dev/sda1 /mnt       #mount to /mnt

yes | pacman -Sy tar curl xz
curl --output kiss.xz https://codeberg.org/attachments/7f91bc9e-6fb1-481f-bacd-95798fbf298c
tar xf kiss.xz -C /mnt
cp chroot.sh /mnt
cp profile /mnt

/mnt/bin/kiss-chroot /mnt ./chroot.sh

cd ..
rm -rf kiss-setup

umount /mnt