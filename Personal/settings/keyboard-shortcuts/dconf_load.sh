#!/bin/bash
#
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.
#
##################################################################################################################

sudo pacman -S dconf dconf-editor

dconf load /org/gnome/shell/keybindings/ < keyboard-shortcuts.dconf

echo "################################################################"
echo "###################    shortcuts loaded   ######################"
echo "################################################################"

sleep 1

