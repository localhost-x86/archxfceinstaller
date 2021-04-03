#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Turkey -a 12 --sort rate --save /etc/pacman.d/mirrorlist

git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si PKGBUILD  --noconfirm

sudo pacman -S --noconfirm xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings xfce4 xfce4-goodies firefox arc-gtk-theme arc-icon-theme

sudo systemctl enable lightdm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
