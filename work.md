sudo pacman -S qemu virt-manager dnsmasq iptables-nft
sudo pacman -S edk2-ovmf

dd if=/dev/zero of=efi1 bs=1M count=100
dd if=/dev/zero of=efi2 bs=1M count=1

sudo ./start_md0
or
sudo ./stop_md0

sudo parted /dev/md0
unit s
mktable gpt
mkpart primary fat32 2048 204799    # depends on size of efi1 file
mkpart primary ntfs 204800 -2049    # depends on size of efi1 and efi2 files
set 1 boot on
set 1 esp on
set 2 msftdata on
name 1 EFI
name 2 Windows
quit