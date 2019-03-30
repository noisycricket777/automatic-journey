#!/bin/bash
#set -e
###########################################################################################################

# software from AUR (Arch User Repositories)
# https://aur.archlinux.org/packages/

sh AUR/install-insync-v*.sh
sh AUR/install-numix-folders-git-v*.sh
sh AUR/install-gpmdp-v*.sh
sh AUR/install-the-platinum-searcher-bin-v*.sh
sh AUR/install-dropbox-v*.sh
sh AUR/install-virtualbox-for-linux-v*.sh

# these come last always
echo "Checking if icons from applications have a hardcoded path"
echo "and fixing them"
echo "Wait for it ..."
sudo hardcode-fixer

echo "################################################################"
echo "####        Software from AUR Repository installed        ######"
echo "################################################################"
