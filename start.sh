#!/bin/sh

yes | apt install tar curl xz-utils
curl --output kiss.xz https://codeberg.org/kiss-community/repo/releases/download/23.04.30/kiss-chroot-23.04.30.tar.xz
tar xf kiss.xz -C /mnt
cp chroot.sh /mnt
cp profile /mnt

/mnt/bin/kiss-chroot /mnt << EOT
./chroot.sh
EOT
