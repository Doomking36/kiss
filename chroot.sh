#!/bin/sh

mkdir -p /home/dk/repos
mv profile /home/dk
cd /home/dk
mv profile ~/.profile

git clone https://github.com/kiss-community/repo /home/dk/repos/repo
git clone https://github.com/kiss-community/community /home/dk/repos/community
git clone https://github.com/ehawkvu/kiss-xorg /home/dk/repos/xorg

. ~/.profile

echo | kiss u
echo | kiss U
echo | kiss b baseinit grub e2fsprogs dhcpcd ncurses libelf perl vim libudev-zero util-linux

git clone https://github.com/Doomking36/vmware
cd vmware
mv vm* /boot
mv Sys* /boot
mv CON* /root
cd ..
rm -rf vmware

echo "kiss" > /etc/hostname
echo "127.0.0.1 kiss.localdomain kiss::1 kiss.localdomain kiss ip6-localhost" > /etc/hosts

passwd
adduser -h /home/dk dk
addgroup dk wheel

su dk << EOT
git clone https://github.com/Doomking36/kiss-setup
cp kiss-setup/profile /home/dk
mv profile ~/.profile
EOT
curl -fLO https://github.com/cemkeylan/genfstab/raw/master/genfstab
chmod +x genfstab
./genfstab -U / >> /etc/fstab

tune2fs -O ^metadata_csum_seed /dev/sda1

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
