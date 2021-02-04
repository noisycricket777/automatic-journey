### Install updates and reboot[](#install-updates-and-reboot)

    sudo dnf upgrade --refresh
    sudo dnf check
    sudo dnf autoremove
    sudo fwupdmgr get-devices
    sudo fwupdmgr refresh --force
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
    sudo reboot now
 
# Enable RPM Fusion free/nonfree repos

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

* to enable the RPM Fusion free and nonfree repositories. Afterwards I run

    sudo dnf upgrade --refresh
    sudo dnf groupupdate core
    sudo dnf install -y rpmfusion-free-release-tainted
    sudo dnf install -y dnf-plugins-core
# To enable DVD playback in Fedora, enable the Tainted RPM Fusion repository. After enabling, install the libdvdcss package.

sudo dnf install -y rpmfusion-free-release-tainted 
sudo dnf install -y libdvdcss 

# The Nonfree Tainted repository contains software that may have ambiguous copyright or distribution rules. The firmware command will install additional drivers that help with hardware compatibility.

sudo dnf install -y rpmfusion-nonfree-release-tainted 
sudo dnf install -y *-firmware

# AppStream will display the RPM Fusion software in Gnome Software and KDE Discover.

sudo dnf -y groupupdate core

# The following command will adds packages for gstreamer enabled applications.

sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin 

# This package install complement packages needed by some applications for sound and video.

sudo dnf -y groupupdate sound-and-video

### Flatpak support[](#flatpak-support)

Flatpak is installed by default on Fedora Workstation, but one needs to enable the Flathub store:

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak update
    
    

### Snap support[](#snap-support)

Enabling snap support boils down to running the following commands:

    sudo dnf install -y snapd
    sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
    sudo reboot now
    

The restart is needed to ensure snap’s paths are updated correctly. After the reboot, check whether there are any updates:

    sudo snap refresh

# Gnome Tweak Tool makes it easy to modify the system

sudo dnf install -y gnome-tweak-tool 

# VLC is a popular media player.

sudo dnf install -y vlc 

# Additional codecs to cover multimedia

sudo dnf install gstreamer1-{plugin-crystalhd,ffmpeg,plugins-{good,ugly,bad{,-free,-nonfree,-freeworld,-extras}{,-extras}}} libmpg123 lame-libs --setopt=strict=0 -y

# GParted – partition management utility

sudo dnf -y install gparted

# Improved fonts. Enable the better fonts repo and then install the fonts.

sudo dnf copr enable dawid/better_fonts 

sudo dnf install -y fontconfig-enhanced-defaults fontconfig-font-replacements

Step 1: Add WineHQ repository
-----------------------------

Start by adding WineHQ repository with the latest stable packages for Wine.

**Fedora 33:**


    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/32/winehq.repo

-----------------------------------------------

Step 2: Install Wine 6 on Fedora 33/32/31/30/29


**Stable branch** – (**_Recommended_**)

    sudo dnf -y install winehq-stable

# **Install Additional Desktop Environments**
    sudo dnf grouplist -v hidden
    sudo dnf install @cinnamon-desktop-environment @cinnamon-desktop @enlightenment-desktop @electronic-lab @platform-vmware
