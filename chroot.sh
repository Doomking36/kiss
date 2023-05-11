#!/bin/sh

mkdir -p /home/dk/repos
mv profile /home/dk
cd /home/dk
mv profile ~/.profile

chmod u+s /usr/bin/busybox-suid

git clone https://github.com/kiss-community/repo /home/dk/repos/repo
git clone https://github.com/kiss-community/community /home/dk/repos/community
git clone https://github.com/ehawkvu/kiss-xorg /home/dk/repos/xorg

. ~/.profile

yes | kiss u
yes | kiss U
yes | kiss b baseinit grub e2fsprogs dhcpcd ncurses libelf perl vim libudev-zero util-linux opendoas

git clone https://github.com/Doomking36/vmware
cd vmware
mv vm* /boot
mv Sys* /boot
mv CON* /root
cd ..
rm -rf vmware

echo "kiss" > /etc/hostname
echo "127.0.0.1 kiss.localdomain kiss::1 kiss.localdomain kiss ip6-localhost" > /etc/hosts

echo root:123 | chpasswd
adduser -h /home/dk dk
echo dk:123 | chpasswd
addgroup dk wheel

echo permit persist :wheel >> /etc/doas.conf
echo permit :wheel cmd env >> /etc/doas.conf

su dk << EOT
git clone https://github.com/Doomking36/kiss-setup
cp kiss-setup/profile /home/dk
mv profile ~/.profile
EOT

curl -fLO https://github.com/cemkeylan/genfstab/raw/master/genfstab
chmod +x genfstab
./genfstab -U / >> /etc/fstab

rm -rf genfstab kiss-setup/
cd /
rm -rf chroot.sh

yes | kiss b efibootmgr wpa_supplicant dosfstools tzdata

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

tune2fs -O ^metadata_csum_seed /dev/sda1
echo GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
