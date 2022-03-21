#!/usr/bin/env bash
WIN=/dev/sdb1
EFIDIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

set -e

if [[ -e /dev/md0 ]]; then
  echo "/dev/md0 already exists"
  exit 1
fi

if mountpoint -q -- "${WIN}"; then
  echo "Unmounting ${WIN}..."
  umount ${WIN}
fi
modprobe loop
modprobe linear
LOOP1=$(losetup -f)
losetup ${LOOP1} "${EFIDIR}/efi1"
LOOP2=$(losetup -f)
losetup ${LOOP2} "${EFIDIR}/efi2"
mdadm --build --verbose /dev/md0 --chunk=512 --level=linear --raid-devices=3 ${LOOP1} ${WIN} ${LOOP2}
chown $USER:disk /dev/md0
echo "$LOOP1 $LOOP2" > ~/.win10-loop-devices
