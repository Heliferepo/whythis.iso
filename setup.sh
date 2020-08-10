#!/usr/bin/env bash

## Colors
R='\033[1;31m'
B='\033[1;34m'
C='\033[0;36m'
G='\033[1;32m'
W='\033[1;37m'
Y='\033[1;33m'

## Packages
DIR="$(pwd)"
PKG1="colorpicker"
PKG2="betterlockscreen"
PKG3="ksuperkey"
PKG4="networkmanager-dmenu-git"
PKG5="obmenu-generator"
PKG6="perl-linux-desktopfiles"
PKG7="plymouth"
PKG8="polybar"
PKG9="yay"
PKG10="rofi-git"
PKG11="compton-tryone-git"

## Banner
echo
echo -e $B" ┌──────────────────────────────────┐"
echo -e $B" │   $R┏━┓┏━┓┏━╸╻ ╻   ╻  ╻┏┓╻╻ ╻╻ ╻   $B│"
echo -e $B" │   $R┣━┫┣┳┛┃  ┣━┫   ┃  ┃┃┗┫┃ ┃┏╋┛   $B│"
echo -e $B" │   $R╹ ╹╹┗╸┗━╸╹ ╹   ┗━╸╹╹ ╹┗━┛╹ ╹   $B│"
echo -e $B" └──────────────────────────────────┘"
echo
echo -e $W"  By:$C nolifedotsh"
echo -e $W"  Github:$C @nolifedotsh"
echo

## Setting Things Up
echo -e $Y"[*] Installing Dependencies - "$C
echo
sudo pacman -Sy git archiso bison mkinitcpio mkinitcpio-archiso edk2-shell --noconfirm
echo
echo -e $G"[*] Succesfully Installed."$C
echo
echo -e $Y"[*] Modifying /usr/bin/mkarchiso - "$C
sudo cp /usr/bin/mkarchiso{,.bak} && sudo sed -i -e 's/-c -G -M/-i -c -G -M/g' /usr/bin/mkarchiso
echo
echo -e $G"[*] Succesfully Modified."$C

## Cloning AUR Packages
cd $DIR/pkgs

echo
echo -e $Y"[*] Downloading AUR Packages - "$C
echo
echo -e $Y"[*] Cloning $PKG1 - "$C
git clone https://aur.archlinux.org/colorpicker.git --depth 1 $PKG1
echo
echo -e $Y" [*] Cloning $PKG2 - "$C
git clone https://aur.archlinux.org/betterlockscreen.git --depth 1 $PKG2
echo
echo -e $Y"[*] Cloning $PKG3 - "$C
git clone https://aur.archlinux.org/ksuperkey.git --depth 1 $PKG3
echo
echo -e $Y"[*] Cloning $PKG4 - "$C
git clone https://aur.archlinux.org/networkmanager-dmenu-git.git --depth 1 $PKG4
echo
echo -e $Y"[*] Cloning $PKG5 - "$C
git clone https://aur.archlinux.org/obmenu-generator.git --depth 1 $PKG5
echo
echo -e $Y"[*] Cloning $PKG6 - "$C
git clone https://aur.archlinux.org/perl-linux-desktopfiles.git --depth 1 $PKG6
echo
echo -e $Y"[*] Cloning $PKG7 - "$C
git clone https://aur.archlinux.org/plymouth.git --depth 1 $PKG7
echo
echo -e $Y"[*] Cloning $PKG8 - "$C
git clone https://aur.archlinux.org/polybar.git --depth 1 $PKG8
echo
echo -e $Y"[*] Cloning $PKG9 - "$C
git clone https://aur.archlinux.org/yay.git --depth 1 $PKG9
echo
echo -e $Y"[*] Cloning $PKG10 - "$C
git clone https://aur.archlinux.org/rofi-git.git --depth 1 $PKG10
echo
echo -e $Y"[*] Cloning $PKG11 - "$C
git clone https://aur.archlinux.org/compton-tryone-git.git --depth 1 $PKG11
echo

packages=("$PKG1" "$PKG2" "$PKG3" "$PKG4" "$PKG5" "$PKG6" "$PKG7" "$PKG8" "$PKG9" "$PKG10" "$PKG11")
	for packages in "${packages[@]}"; do
		if [[ -d "$packages" ]]; then
			echo -e $G"[*] $B${packages}$G Downloaded Successfully."$C
		else
			echo -e $R"[*] Failed to download $B${packages}$R, Exiting..." >&2
			echo
			exit 1
        fi
    done
    
## Building AUR Packages
mkdir -p ../localrepo/i686 ../localrepo/x86_64

echo
echo -e $Y"[*] Building AUR Packages - "$C
echo

echo -e $Y"[*] Building $PKG1 - "$C
cd $PKG1 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG2 - "$C
cd $PKG2 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG3 - "$C
cd $PKG3 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG4 - "$C
cd $PKG4 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG5 - "$C
cd $PKG5 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG6 - "$C
cd $PKG6 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG7 - "$C
cd $PKG7
cp -r $DIR/pkgs/circuit $DIR/pkgs/plymouth
sed -i '$d' PKGBUILD
cat >> PKGBUILD <<EOL
  sed -i -e 's/Theme=.*/Theme=circuit/g' \$pkgdir/etc/plymouth/plymouthd.conf
  sed -i -e 's/ShowDelay=.*/ShowDelay=1/g' \$pkgdir/etc/plymouth/plymouthd.conf
  cp -r ../../circuit \$pkgdir/usr/share/plymouth/themes
}
EOL
sum1=$(md5sum lxdm-plymouth.service |  awk -F ' ' '{print $1}')
cat > lxdm-plymouth.service <<EOL
[Unit]
Description=LXDE Display Manager
Conflicts=getty@tty1.service
After=systemd-user-sessions.service getty@tty1.service plymouth-quit.service

[Service]
ExecStart=/usr/sbin/lxdm
Restart=always
IgnoreSIGPIPE=no

[Install]
Alias=display-manager.service
EOL
sum2=$(md5sum lxdm-plymouth.service |  awk -F ' ' '{print $1}')
sed -i -e "s/$sum1/$sum2/g" PKGBUILD
makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG8 - "$C
cd $PKG8 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG9 - "$C
cd $PKG9 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG10 - "$C
cd $PKG10 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

echo -e $Y"[*] Building $PKG11 - "$C
cd $PKG11 && makepkg -s
mv *.pkg.tar.zst ../../localrepo/x86_64
cd ..

cd $DIR/localrepo/x86_64
ptars=($PKG1-* $PKG2-* $PKG3-* $PKG4-* $PKG5-* $PKG6-* $PKG7-* $PKG8-* $PKG9-* $PKG10-* $PKG11-*)
	for ptars in "${ptars[@]}"; do
		if [[ -f "$ptars" ]]; then
			echo -e $G"[*] Package $B${ptars}$G Generated Successfully."$C
		else
			echo -e $R"[*] Failed to build $B${ptars::-2}$R, Exiting..." >&2
			echo
			exit 1
        fi
    done

## Setting up LocalRepo
echo -e $Y"[*] Setting Up Local Repository - "$C
echo
repo-add localrepo.db.tar.gz *
echo
echo -e $Y"[*] Appending Repo Config in Pacman file - "$C
echo
echo "[localrepo]" >> $DIR/customiso/pacman.conf
echo "SigLevel = Optional TrustAll" >> $DIR/customiso/pacman.conf
echo "Server = file://$DIR/localrepo/\$arch" >> $DIR/customiso/pacman.conf
echo

## Changing ownership to root to avoid false permissions error
echo -e $Y"[*] Making owner ROOT to avoid problems with false permissions."$C
sudo chown -R root:root $DIR/customiso/
echo

## Cleaning up
echo -e $Y"[*] Cleaning Up... "$C
cd $DIR/pkgs
rm -rf $PKG1 $PKG2 $PKG3 $PKG4 $PKG5 $PKG6 $PKG7 $PKG8 $PKG9 $PKG10 $PKG11
echo
echo -e $G"[*] Setup Completed."
echo
exit
