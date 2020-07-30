
#Base Installation
#==================

1. Prepare Installation
========================

parted:
  mklabel gpt
  mkpart primary 1MiB 513MiB
  mkpart primary 513MiB 4609MiB
  mkpart primary 4609MiB 100%
  print
  quit
  
LUKS Encryption: Automatic LUKS Encryption
Mount Partitions:
 - root (/dev/mapper/cryptroot): ssd,noatime,space_cache,commit=120,compress=zstd
 - Confirm Subvols (home and cache)
 - SWAP (select swap part)
 - Finish
 - Select UEFI part: /boot/efi
 
Mirrors: Rank Mirrors by Speed
Refresh Pacman Keys

2. Install Desktop System
==========================

- yay+base-devel and current STABLE kernel: https://kernel.org/
- Gnome
- no extra (Macbook add: broadcom-wl driver)
- Gnome full

- Bootloader: Grub

Configure Base:
- FSTAB: UUID

REVIEW CONFIG!!!!!!!!!!!
Check:
- fstab: Correct UUID set?
- copy @home subvol for @cache! and mount it to /var/cache e.g.
UUID={uuid of cryptroot} /var/cache	btrfs		rw,noatime,compress=zstd:3,ssd,space_cache,commit=120,subvol=@cache	0	0
 
for swap:
UUID=... none      	swap      	defaults,pri=-2	0 0

for efi:
UUID=1234-012E      	/boot/efi 	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro	0 0

-grub:
check whether in GRUB_CMDLINE_LINUX there is your cryptdevice=UUID=…:cryptroot, GRUB_ENABLE_CRYPTODISK=y

FINISH: 
sudo reboot now

#post installs
sudo pacman-mirrors -c Germany
sudo pacman -Syyu

sudo pacman -S timeshift timeshift-autosnap grub-btrfs
sudo timeshift-gtk

Monthly: 2
Daily: 5
Boot: 3
Stop cron emails for scheduled tanks: yes
Include @home subvol: yes

Creat a snapshot

ls /run/timeshift/backup
#timeshift config
cat /etc/timeshift.json

sudo nano /etc/timeshift-autosnap.conf
snapshotBoot=false

sudo nano /etc/default/grub-btrfs/config
set a GRUB_BTRFS_SUBMENUNAME

sudo timeshift-autosnap

# Enable fstrim.timer for SSD and NVME
sudo systemctl enable fstrim.timer

#Move /var/cache into @cache (if you forgott to mount it at installation)
cd /run/timeshift/backup/@/var/cache
ls | xargs sudo mv -t /run/timeshift/backup/@cache/

export CRYPTUUID=$(blkid -s UUID -o value /dev/mapper/cryptroot)
echo "UUID=${CRYPTUUID}    /var/cache    btrfs    rw,noatime,compress=zstd:3,ssd,space_cache,commit=120,subvol=@cache 0 0" >> /etc/fstab
sudo mount -av

#check mounts, and check if /var/tmp is tmpfs!
mount | grep tmpfs

# WLAN driver if you forgot
sudo pacman -S broadcom-wl

#tools
sudo pacman -S htop neofetchq wireless_tools net-tools gnome-nettool

#creat VLAN
nm-connection-editor

# Disable Macbook S/PDIF
sudo alsamix
select soundcard with F6
Mute S/PDIF with m (all channel!)
sudo alsactl store|restore

#install zRAM
sudo pamac install systemd-swap
sudo nano /etc/systemd/swap.conf

zswap_enabled=0
zram_size=$(( RAM_SIZE ))
swapfc_enabled=1

sudo systemctl enable --now systemd-swap

# Change swappiness for SSD
cat /proc/sys/vm/swappiness
# 60
cat /proc/sys/vm/vfs_cache_pressure
# 100

#when using zram compression you want to encourage the eagerness to swap to take advantage of memory compression.
sudo sysctl vm.swappiness=100

# Enable Grub menu
#first try to use Grub Customier GUI by disable/re-enabeling it
sudo grub-editenv - unset menu_auto_hide
sudo update-grub

#install emoji font
install noto-fonts-emoji
