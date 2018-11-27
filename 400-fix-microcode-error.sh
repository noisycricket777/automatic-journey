#!/bin/bash
set -e

# [    0.000000] [Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0x52 (or later)


sudo pacman -S intel-ucode --noconfirm
sudo grub-mkconfig -o /boot/grub/grub.cfg


echo "################################################################"
echo "####                             Fix done                 ######"
echo "################################################################"
