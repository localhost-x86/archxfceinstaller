#!/bin/bash

set -e

getxfce() {
	# Lokal değişkenler:
	local CWD="/tmp/getxfce"
	
	# Kurulum ortamı için ön hazırlık:
	[[ -d "${CWD}" ]] && rm -rf "${CWD}"
	mkdir -p "${CWD}"
	cd "${CWD}"
	
	# Gerekliliklerin ve kurulum ortamının hazırlanması:
	echo "After the complete all jobs, the script will be restart your computer."
	timedatectl set-ntp true
	hwclock --systohc
	reflector -c Turkey -a 12 --sort rate --save "/etc/pacman.d/mirrorlist"	
	echo -e "\tInstalling required softwares and programs."
	pacman -S --noconfirm "xorg" "lightdm" "lightdm-gtk-greeter" "lightdm-gtk-greeter-settings" "xfce4" "xfce4-goodies" "firefox" "arc-gtk-theme" "arc-icon-theme"
	systemctl enable "lightdm"

	## Yay aur yardımcı aracının kurulumu:
	echo -e "\tGetting yay aur helper.."
	git clone "https://aur.archlinux.org/yay.git"
	cd "yay"
	makepkg -si "PKGBUILD" --noconfirm
	reboot
}

if [[ "${UID}" = 0 ]] ; then
	getxfce
elif command -v sudo &> /dev/null ; then
	sudo getxfce
else
	echo -e "\tPlease run it as root privalages.."
	exit 1
fi
