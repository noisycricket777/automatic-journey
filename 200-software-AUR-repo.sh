!/bin/bash
set -e
###########################################################################################################

# software from AUR (Arch User Repositories)
# https://aur.archlinux.org/packages/

sh AUR/install-insync-v*.sh
sh AUR/install-neofetch-v*.sh
sh AUR/install-gpmdp-v*.sh
sh AUR/install-the-platinum-searcher-bin-v*.sh
sh AUR/install-dropbox-v*.sh
sh AUR/install-meld-v*.sh
sh AUR/install-sublime-text-v*.sh
sh AUR/install-joplin-v*.sh
sh AUR/install-boostnote-v*.sh
sh AUR/install-clipgrab-v*.sh
sh AUR/install-grsync-v*.sh
sh AUR/install-mkchromecast-v*.sh
sh AUR/install-grsync-v*.sh
sh AUR/install-variety-v*.sh
sh AUR/install-zsh-v*.sh
sh AUR/install-hardcode-fixer-git-v*.sh

sh strap.sh




# these come last always
echo "Checking if icons from applications have a hardcoded path"
echo "and fixing them"
echo "Wait for it ..."
sudo hardcode-fixer

echo "################################################################"
echo "####        Software from AUR Repository installed        ######"
echo "################################################################"
