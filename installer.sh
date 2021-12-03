#!/bin/sh
sudo pacman -Sy --noconfirm git rustup --needed base-devel
rustup toolchain install stable
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -sic
cd ..
paru --gendb
paru -Sy --skipreview --noconfirm --useask bash-git dash-git dashbinsh sway-git swaybg-git swayidle-git swayidle-git wlroots-git
