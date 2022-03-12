echo 301203 | sudo -S clear
sudo losetup -f "/home/slightlywind/repositories/scripts/WindstationVirtual/efi1"
sudo losetup -f "/home/slightlywind/repositories/scripts/WindstationVirtual/efi2"
set EFI1 (losetup -a | grep "efi1" | cut -c1-11)
set EFI2 (losetup -a | grep "efi2" | cut -c1-11)
sudo mdadm --build --verbose /dev/md0 --chunk=512 --level=linear --raid-devices=3 $EFI1 /dev/sdb1 $EFI2
sudo sleep 1
sudo chown slightlywind:slightlywind /dev/md0