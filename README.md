# WhyThis

## Features

+ Offline Installer - Installable ISO
+ Enabled Encryption Settings By Default
+ Grub - With Themes - Configured/Customized
+ Plymouth - Arch Themes - Configured/Customized
+ Xorg Server / GUI - *Intel Video Drivers*
+ LXDM Display Manager - Configured/Customized
+ Openbox WM (Default), i3WM & LXDE Sessions - Configured/Customized
+ Network Manager - Mobile Broadband, USB/Bluetooth Tethering, nm-applet,nm_dmenu
+ Full File Manager Functionality - Partition Mounting, Network Access, Thumbnails Etc
+ Virtualbox Support
+ Compton Tryone - With Blur
+ Dunst - Notifications - Configured For Each Session
+ Polybar - With All
+ Rofi - Custom Menus, Themes
+ Yay - AUR helper
+ Shell, Vim, Ranger, etc - Configured
+ eDEX-UI - Optional
+ Pulseaudio - Audio Support
+ Mpd, Mpc, Ncmpcpp - Album Art Support
+ Mplayer - Video Player
+ Terminals - termite, urxvt(compiled with pixbuf), xfce4-terminal, lxterminal
+ GUI - Thunar, Pcmanfm, Geany, Leafpad, Atril, Viewnior, Feh, Etc
+ CLI - vim, ranger, mc/mcedit, htop, bmon, nmon, neofetch, Etc
+ And a lot, don't remember everything, check the source

## How To Get ISO

**1. Download -** You can either download already generated ISO file, or...
 //TODO
 
**2. Build ISO -** If you're already using archlinux & want to build the iso, maybe with your config then...

***Check list***
- [ ] At least 10GB of free space
- [ ] Arch Linux 64-bit only
- [ ] Clear pacman cache; ```sudo pacman -Scc```
- [ ] Configure everything as *root*
- [ ] Disable auto updates

+ Open the terminal & clone this repo 
```bash
git clone --single-branch --branch master --depth=1 https://github.com/nolifedotsh/whythis.git archlinux
```

+ After cloning, run *'setup.sh'*, it'll install the dependencies, AUR packages, Fix Permissions, Etc. Be Patient!
```bash
cd whythis
chmod +x setup.sh
./setup.sh
```

+ Now, Change to *'customiso'* directory & get ***ROOT*** & Run *'build.sh'*
```bash
cd customiso
sudo su
./build.sh -v
```

+ If everything goes well, you'll have the ISO in *'customiso/out'* directory. <br />

> If you want to Rebuild the ISO, remove ***work*** & ***out*** dirs inside `customiso` directory first. then run `./build.sh -v` as **root**. You don't need to run *'setup.sh'* again, it's a one time process only. 

## Boot The ISO

**1. Using GRUB -** If you're already using a linux distro, with grub, then you can add following entry in your *'grub.cfg'* file, Replace **"X"** with your partition number, and *'path_to_your_iso'* with ISO path, which can be *(/home/USERNAME/archlinux/customiso/out/archlinux-xxxx.xx.xx-x86_64.iso)* <br />
```
menuentry 'Arch Linux Live' --class arch --class gnu-linux --class linux {
    set root='(hd0,X)'
    set isofile="path_to_your_iso"
    set dri="free"
    search --no-floppy -f --set=root $isofile
    probe -u $root --set=abc
    set pqr="/dev/disk/by-uuid/$abc"
    loopback loop $isofile
    linux  (loop)/arch/boot/x86_64/vmlinuz img_dev=$pqr img_loop=$isofile driver=$dri quiet loglevel=3 systemd.show_status=false udev.log-priority=3 vt.global_cursor_default=0 splash cow_spacesize=1G
    initrd  (loop)/arch/boot/intel_ucode.img (loop)/arch/boot/x86_64/archiso.img
}

```
<br />

**2. Using dd -** Alternatively, you can use ***dd*** command to make a bootable USB_Drive/SDcard, Just open the terminal and... <br />
```bash
sudo su
dd bs=4M if=path_to_iso of=/dev/sdX status=progress oflag=sync
```
<br />

**3. Using Etcher -** If you use *Windows*, or maybe linux but afraid of ***dd***, then you can use [Etcher](https://www.balena.io/etcher/) to make a bootable USB/SDcard. More Options [Here](https://wiki.archlinux.org/index.php/USB_flash_installation_media)
<br />
