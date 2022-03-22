rm efi*

dd if=/dev/zero of=efi1 bs=1M count=100
dd if=/dev/zero of=efi2 bs=1M count=1

chmod 666 efi*

./start_md0.sh

sudo parted /dev/md0 < parted.script
