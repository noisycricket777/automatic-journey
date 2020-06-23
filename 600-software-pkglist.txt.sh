#!/bin/bash
#set -e
###########################################################################################################

# software from AUR (Arch User Repositories)
# https://aur.archlinux.org/packages/

 

yay -S --needed -<pkglist-aur.txt
yay -S --needed -<pkglist-repo.txt
yay -S --needed -<AURpkglist.txt
yay -S --needed -<pkglist-games.txt
yay -S --needed -<games_from_aur.txt
# these come last always

echo "Checking if icons from applications have a hardcoded path"
echo "and fixing them"
echo "Wait for it ..."
sudo hardcode-fixer

echo "################################################################"
echo "####        Software from AUR Repository installed        ######"
echo "################################################################"
