#!/bin/sh

yes | pacman -Sy tar curl xz
curl --output kiss.xz https://codeberg.org/attachments/7f91bc9e-6fb1-481f-bacd-95798fbf298c
tar xf kiss.xz -C /mnt

/mnt/bin/kiss-chroot /mnt << "EOT"

mkdir -p /home/dk/repos
cd /home/dk

git clone https://github.com/kiss-community/repo /home/dk/repos/repo
git clone https://github.com/kiss-community/community /home/dk/repos/community
git clone https://github.com/ehawkvu/kiss-xorg /home/dk/repos/xorg

echo "KISS_PATH=/home/dk/repos/repo/core" >> ~/.profile
echo "KISS_PATH=$KISS_PATH:/home/dk/repos/repo/extra" >> ~/.profile
echo "KISS_PATH=$KISS_PATH:/home/dk/repos/repo/wayland" >> ~/.profile
echo "KISS_PATH=$KISS_PATH:/home/dk/repos/xorg/extra" >> ~/.profile
echo "KISS_PATH=$KISS_PATH:/home/dk/repos/xorg/xorg" >> ~/.profile
echo "KISS_PATH=$KISS_PATH:/home/dk/repos/xorg/community" >> ~/.profile
echo "KISS_PATH=$KISS_PATH:/home/dk/repos/community/community" >> ~/.profile
echo "export KISS_PATH" >> ~/.profile

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

su dk
git clone https://github.com/Doomking36/kiss-setup
cp kiss-setup/profile ~/.profile
. ~/.profile
exit

curl -fLO https://github.com/cemkeylan/genfstab/raw/master/genfstab
chmod +x genfstab
./genfstab -U / >> /etc/fstab

tune2fs -O ^metadata_csum_seed /dev/sda

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
EOT
