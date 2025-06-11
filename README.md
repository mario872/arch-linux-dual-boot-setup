# Arch Linux Dual Boot Install
A short guide to dual boot arch linux
### Set Font Size in Terminal
Set font size command: ```setfont ter-132n```
### Connecting to the Internet
Enter live wifi connection terminal interface (```iwctl```)
Then, inside the interface, connect to wifi using this command:
```iwctl --passphrase your_passphrase_here station your_device_wlan0 connect your_network_name_here```
 Exit out of here, then ```ping archlinux.org```
 If you are receiving packets, then you're successfully connecte to the internet
 
 ### Checking EFI Boot
 Run the following command, if you get a long string of folders, you are using efi
 ```ls /sys/firmware/efi/efivars/```
 
 ### Setting Time and Date
 First, list the timezones available:  ```timedatectl list-timezones```
 Then, set your timezone: ```timedatectl set-timezone your_timezone_here```
 
 ### Setting Keyboard Layout
 The command ```loadkeys``` is waht we're using to set the console keyboard layout
 If you want US keyboard layout replace ```your_layout_here``` with ```us.map.gz```, if you want UK keyboard layout, replace it with ```uk.map.gz```
 The full command is: ```loadkeys /usr/share/kbd/keymaps/i386/qwerty/your_layout_here```
 
 ### Creating Partitions for Arch Linux
 #### Checking available disks
 First, run ```lsblk``` this is a command we will use a lot, this lists all drives on your system. Ignore ```loop0``` and anything your usb drive (usually mounted at ```/run/archiso/bootmnt```)
 Usually, the only other one is the drive you want to install arch linux on. You should have created an empty partition earlier with a size you noted down. Find this one in the drive, rem ember it's name.
 #### Creating New Partitions
 To open the partitions editor run ```cfdisk /dev/name_of_your_DRIVE_here```. Note, don't use the PARTITION we remembered earlier, use the DISK name.
 This will open up a GUI dialog, use the arrow keys to move up and down and select options. Select the free space by moving to it and pressing enter, this will open a dialog to create a new partition.
 We will be making 2 partitions only. This is because I prefer to create 2 instead of three, the third would be your home partition, but if you create this (instead of it being created automatically), it will be confined to the amount of space you give it, as opposed to having one partition for the whole system as I prefer.
 The first partition will be the swap partition, this is necessary, I don't know why. After selecting the free space, enter the size you need for your swap partition, a good guide is the size of your RAM+2GB. If you have 8GB of ram, allocate a 10GB swap partition. Select this partition you just created again, and use the left and right arrow keys to navigate to the ```type``` selector, press enter, and change the type of the partition to ```Linux swap```.
 After this, navigate to the rest of your free space, select it with enter, and allocate the rest of the free space to it, press enter, and you're done with partitions!
 **Make sure you're happy with the changes to your disk drive, as it you get this wrong, there may be loss of data.**
 Now, navigate to the ```write``` button, and type ```yes``` to confirm the changes, then navigate to the ```quit``` button.
 Run ```lsblk``` to check the partitions were written, and you should see a newly created partition! (Only one, because there was the free space before, remember?)
 #### Formatting Partitions
 To format your ```root``` partition, run the command ```mkfs.ext4 /dev/root_partition_name_here```, you should have found the name of the root partition from running ```lsblk``` earlier.
 To do the equivalent for the ```swap``` partition, run the command ```mkswap /dev/your_swap_partition_name_here```. Then run the command ```swapon /dev/your_swap_partition_name_here```, this will enable the swap partition's usage.
 
 ### Mounting the Operating System to the New Partitions
 First, mount the root partition with the command ```mount /dev/root_pratition_name_here```
 You can now run ```lsblk``` to see the changes to where your partitions are mounted. You'll see that next to your swap partition it says ```[SWAP]```, and next to root it says ```/mnt```
 
 ### Installing OS
 To install just the base operating system, run ```pacstrap -i /mnt base base-devel linux linux-lts linux-headers linux-firmware sudo``` then write either ```intel-ucode``` or ```amd-ucode``` depending on your system. All on the same line, you can then install the recomended packages, ```nano vim git neofetch networkmanager dhcpcd pulseaudio bluez wpa_supplicant```. Then, proceed with installation! Wait some time for the command to complete and don't interrupt it.
If you now run ```ls /mnt``` and see lots of folders, your installation has succeeded! One last command for the OS installation is  ```genfstab -U /mnt >> /mnt/etc/fstab```

### Enter newly installed OS with ```chroot```
Run the command ```arch-chroot /mnt```
#### Setting root password
To set the root password run the command ```passwd``` and follow the prompts to create the password.
#### Adding Normal User
Run the command ```useradd -m your_username_here```, then add the password with ```passwd your_username_here```. Now, to add the use to important groups run ```usemod -aG wheel,storage,power,dialout,docker your_username_here```
#### Give User Sudo Access
Run the command ```EDITOR=nano visudo```, then scroll to the line ```# %wheel ALL=(ALL) ALL```. then remove the ```# ``` and below that add the line, ```Default timestamp_timeout=500```. Then press CTRL+X, then type Y and press enter to exit.
#### Setting System Language
Run ```nano /etc/locale.gen```, the scroll to your langauge followed by some ```UTF-8```s. Remove the ```#``` in this line and save and exit like before.
Then, run ```echo LANG=en_US.UTF-8 > /etc/locale.conf```, or replace ```en_US``` with your language.
After that run ```export LANG=en_US.UTF-8```, or replaced with your language.
#### Setting Hostname
Run the command ```echo your_preferred_hostname_here > /etc/hostname```, to set your computer's hostname.
Then run the command ```nano /etc/hosts``` and add these lines.
```
127.0.0.1       localhost
::1             localhost
127.0.1.1       your_preferred_hostname_here.localdomain            localhost
```
Then save and exit the file.
#### Setting timezone/region
Run the command ```ln -sd /usr/share/zoneinfo/Australia/Sydney /etc/localtime```, but replace ```Australia/Sydney``` with your location. If you need to check, then after typing ```zoneinfo/``` press TAB on your keyboard and scroll. Repeat for after country, to find second location.
Then run ```hwclock --systohc```.
#### Grub UEFI Install
Run the commands ```mkdir /boot/efi5 
                    lsblk```
Then run ```mount /dev/the_first_partition_in_the_list_here /boot/efi/```
Finally, run the command ```pacman -S grub efibootmgr dosfstools mtools os-prober```
#### Configuring GRUB
To enter the text file run ```nano /etc/default/grub```
Then, scroll to the bottom and remove the ```#``` on the line ```#GRUB_DISABLE_OS_PROBER=false```
Then, exit and save using ```Ctrl+x``` then typing ```y``` and clicking ```enter```.
#### Finalising GRUB Install
Run the command ```grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck```
Then, ```grub-mkconfig -o /boot/grub/grub.cfg```
Hopefully, at this point grub will output something along the lines of ```Found Windows Boot Manager on /dev/etcetera/etcetera```
My one, doesn't ever detect windows so this fails, but if it works for you, then that's great!
#### Enabling Networking Services
To enable networking services, you'll need a few commands ```systemctl enable dhcpcd
systemctl enable NetworkManager```
#### Finishing Up
To finish up (before installing the GUI), type ```exit
umount -lR /mnt
reboot```
#### Congratulations!
Congratulations! You've done the bare minimum to get Arch Linux running with Windows as a backup operating system, for when you inevitably type ```sudo rm -rf /```! DO NOT EVER TYPE THAT, THAT DELETES ALL FILE ON YOUR ENTIRE LINUX PARTITION, WITH ONLY ONE ```Are you sure you want to delete everything? (y/N)```. DO NOT RUN THAT
Anyway, now you have to install a GUI, which there are many, many guides out there for, I personally reccomend GNOME, as it's my favourite in terms of look, feel, and community support. Happy hacking!

#### Connect to WiFi On Your New Install
`nmcli device wifi connect SSID_or_BSSID password password`

#### Freebie: Gnome Install
```
sudo pacman -S xorg xorg-server gnome gdm
sudo systemctl enable --now gdm.service
```

#### Freebie: My Recommended Software
The following command installs snap, flatpak, yay, 7zip, Chromium, docker, docker compose, ffmpeg, wget

curl -fsSL https://raw.githubusercontent.com/mario872/arch-linux-dual-boot-setup/refs/heads/main/install-recimmended-software.sh | bash

The following command installs Bambu Studio, Opera, dosfstools, ntfs-3g, esptool, visual studio code, gnome tweaks, gnome extensions, ollama, p3x onenote, teams for linux, thonny, wine, appimagelauncher, rasberry pi imager, kicad

curl -fsSL https://raw.githubusercontent.com/mario872/arch-linux-dual-boot-setup/refs/heads/main/install-extra-software.sh | bash

#### Freebie: Fingerprint Reader Install
https://wiki.archlinux.org/title/Fprint
