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
