#!/bin/sh
/mnt/bin/kiss-chroot /mnt
mkdir -p /home/dk/repos

cd /home/dk
git clone https://github.com/kiss-community/repo /home/dk/repos/repo
git clone https://github.com/kiss-community/community /home/dk/repos/community
git clone https://github.com/ehawkvu/kiss-xorg /home/dk/repos/xorg



. ~/.profile

echo | kiss u
echo | kiss U

