#!/bin/bash
#set -e

#pia VPN Package installer


sudo pacman -S --noconfirm --needed yay
sudo pacman -S --noconfirm --needed trizen
sudo pacman -S --noconfirm --needed yay
sudo pacman -S --noconfirm --needed veracrypt
yay -S --noconfirm --needed vmware-workstation
yay -S --noconfirm --needed google-drive-ocamlfuse-opam




###############################################################################################

echo "################################################################"
echo "###################    core software installed  ################"
echo "################################################################"
