sudo losetup -f efi1
sudo losetup -f efi2

echo  "######Pre-setup"
rm efi*
./stop_md0.sh

echo "\n######Setting up efi files"
dd if=/dev/zero of=efi1 bs=1M count=100
dd if=/dev/zero of=efi2 bs=1M count=1
chmod 666 efi*

echo "\n######Starting md0"
./start_md0.sh

echo "\n######Partitioning md0"
sudo parted /dev/md0 < parted.script

echo "######Final touch"
sudo mkfs.msdos -F 32 -n EFI /dev/md0p1
sudo chown $USER:$USER /dev/md0
