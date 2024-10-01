# How to use it?

1. First, your computer needs to enter the Minimal ISO image of nixos.
[NixOS Website](https://nixos.org/download/)

Type `sudo -i` to login root.


2. Connect to the Internet

For wired connection, just plug in the network cable.
For wireless connection, you need to do the following to connect to the network:

first start wpa_supplicant with `sudo systemctl start wpa_supplicant`, then run `wpa_cli`.

you need to type in the following commands for example:

```
add_network
0

set_network 0 ssid "myhomenetwork"
OK

set_network 0 psk "mypassword"
OK

set_network 0 key_mgmt WPA-PSK
OK

enable_network 0
OK
```


3. Partition

My configuration uses systemd-boot, so it only supports UEFI computers. If you want to know whether it is an EFI-booted system, please enter
ls /sys/firmware/efi/efivars
If there is output, then you are in UEFI mode

Two partitions are set here, which is a common solution.

    EFI partition: /efi 800MB
    Root directory: / All the rest

If you use an NVME SSD, the disk name may be `nvme0n1`.

Enter `lsblk` to display the partition status and find the name of the disk you want to install. The following uses nvme0n1 for demonstration.

Note that this will clear the hard drive data!

```
parted /dev/nvme0n1 -- mklabel gpt # Convert the disk type to gpt. If the disk has data, it will warn you. Just enter yes.
parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 800MB # EFI partition
parted /dev/nvme0n1 -- mkpart primary 800MB 100% # Root directory partition
parted /dev/nvme0n1 -- set 1 esp on # Set EFI system partition (ESP)
```

```
mkfs.vfat -n boot /dev/nvme0n1p1 # Format the efi partition
mkfs.btrfs -L nixos /dev/nvme0n1p2 # Format the root directory as btrfs file system
```


4. Mount

```
mount -t tmpfs none /mnt
mkdir -p /mnt/{boot,nix,etc/nixos}
mount /dev/disk/by-label/nixos /mnt/nix
mount /dev/disk/by-label/boot /mnt/boot
mkdir -p /mnt/nix/persist/etc/nixos
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
```
Here we mount the system to the memory, so that it will remain the same every time the computer restarts. This is a very interesting usage, which can prevent junk files and failures on your computer. If you want to ensure that the data in a certain folder will not disappear after restarting, please modify `modules/nixos/hardware/persistence.nix`.


5. Install the system

```
nix-shell -p nixFlakes neovim git

nixos-generate-config --root /mnt # We generated a basic configuration file, however, just to get the hardware configuration in it.

cd /mnt/etc/nixos
git clone https://github.com/itypiece/xunix
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/xunix/modules/nixos/hardware/hardware-configuration.nix
cd xunix

# The username and host name can be changed in flake.nix. The default user password is 1.

nixos-install --no-root-passwd --flake .#nixos
```
Have fun and good luck!
