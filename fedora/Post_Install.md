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
    
    sudo dnf copr enable kwizart/fedy  
sudo dnf install fedy -y

sudo dnf copr enable kwizart/fedy
sudo dnf install fedy -y

[![Effie Talor](https://miro.medium.com/fit/c/56/56/1*kNZNgLC6JrVe3ykC3xkCRQ.jpeg)](https://eftalor.medium.com/?source=post_page-----f68751eef156--------------------------------)

With the release of [Fedora 33](https://getfedora.org/en/workstation/download/) today, I have decided to go back to my roots and decided to remove Ubuntu for Fedora.

You can say what you want on Ubuntu, but you have got to admit that it has quite a big community and hobby-developers that enables end users to easily install things or do tasks that are rather cumbersome on other Linux distributions. Not to mention the shitload of Ubuntu guides out there… Fedora lacks some of this, however if you are using Fedora I suppose that you more than just an average Linux user…

Therefore, I have decided to come up with this guide, to give Fedora some love… So here we go!

![Image for post](https://miro.medium.com/max/60/1*IVg0Zjt8-mnz6MUVfffF-Q.png?q=20)

![Image for post](https://miro.medium.com/max/534/1*IVg0Zjt8-mnz6MUVfffF-Q.png)

The Fedora Logo

This one is driving me crazy, always…  
I like to always have a text navigation bar.  
**Tip**: to change it temporarily you can simply invoke _ctrl + l_

> Before:

![Image for post](https://miro.medium.com/max/60/1*Ueel8HRnSOlr2myojVua1Q.png?q=20)

![Image for post](https://miro.medium.com/max/1834/1*Ueel8HRnSOlr2myojVua1Q.png)

After:

![Image for post](https://miro.medium.com/max/60/1*PV4chMyNZ9tZxvj4Vln5Ig.png?q=20)

![Image for post](https://miro.medium.com/max/1930/1*PV4chMyNZ9tZxvj4Vln5Ig.png)

Open a terminal and invoke:

> `$ gsettings set org.gnome.nautilus.preferences always-use-location-entry true`

Need I say more?

Head over to [RPMFusion’s](https://rpmfusion.org/Configuration) configuration page, but you’re probably lazy so here you go:

> `$ sudo dnf install [https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-33.noarch.rpm](https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-33.noarch.rpm)`
> 
> `$ sudo dnf install [https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-33.noarch.rpm](https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-33.noarch.rpm)`

DNF is great and have come a long way since the days of Yum, it can be even better by enabling 3 of its plugins:

_fastestmirror_: Selects the fastest mirror server for the DNF updates

_deltarpm_: Instead of downloading the whole RPM update , it just downloads the portion of changed files since the previous update, can save on huge download.

_max\_parallel\_downloads_: DNF by default is set to 3 concurrent downloads, the max is 10 concurrent downloads. I would recommend to set it to 6

Using your favorite editor, edit the DNF configuration file:

> `/etc/dnf/dnf.conf`

Now, add these:

> `fastestmirror=true  
> deltarpm=true  
> max_parallel_downloads=6`

On Ubuntu and others it is rather easy, but in Fedora it might be painful. There are quiet an amount of guides out there which all redirect to dead link to downloads fonts… However there is this way, provided by RPM Fusion (and is not much documented for a reason)

> `$ sudo dnf install lpf-mscore-fonts lpf-cleartype-fonts`

This will install new graphical utilities:

![Image for post](https://miro.medium.com/max/60/1*hRxNHrqD9fpm1jpBZ6Zi0A.png?q=20)

![Image for post](https://miro.medium.com/max/710/1*hRxNHrqD9fpm1jpBZ6Zi0A.png)

Go run them and follow the instructions.

Edit: Nov 4th:  
I found out there is an easier way to overcome the “ugly fonts” problem.  
Enable this Copr repo and enable the installation of various fonts that will act as a replacement to proprietary fonts (ie MS) and will make browsers look better:

sudo dnf copr enable dawid/better\_fontssudo dnf install -y fontconfig-enhanced-defaults fontconfig-font-replacements

Well, I am using Gmail and Gsuite with my browser, but I still want the feel of a local mail client sometimes… Fedora developers have knowingly decided not to include a mail client in Fedora. I get this… Thunderbird cowardly refuses to integrate with the OS it is installed on and looks different. Evolution is too bulky, but there’s one little client that should satisfy the average user:

> `$ sudo dnf install geary`

I might have missed that, but installation had no choice for setting the hostname, but we can easily amend it by invoking the below:

> `$ sudo hostnamectl set-hostname my-new-lovely-computer`

Starting Gnome 3.36 there’s an app for managing you extensions, which is strangely not installed by default on Fedora

> `$ sudo dnf install gnome-extensions-app`

(and if we're at it, let’s also install gnome-tweaks though it is somewhat redundant by now…)

> `$ sudo dnf _install_ gnome-tweaks`

Recently I have found out that PulseAudio (the sound server) has an option to do echo and noise cancellation, I think it is kinda handy it these Zoom-infused times.

Using you favorite editor, edit the PulseAudio configuration file:

> `/etc/pulse/default.pa`

Add this somewhere in the file (its end is probably good)

.ifexists module-echo-cancel.so  
load-module module-echo-cancel aec\_method=webrtc source\_name=echocancel sink\_name=echocancel1  
set-default-source echocancel  
set-default-sink echocancel1  
.endif

Now we need to kill PulseAudio (it will restart automatically)

> `$ pulseaudio -k`

Your audio devices should now have a longer name specifying there is noise cancellation:

![Image for post](https://miro.medium.com/max/1030/1*GyV_hhlf-3T1vriNrCz_qQ.png)

Oh, and if you feel like tweaking your web camera video settings:

> `$ sudo dnf install guvcview`

Gnome-software by itself already has flatpaks enabled by default, however for the the _flatpak_ command line tool it is not (and well, I like to do things from the terminal) so:

> `$ flatpak remote-add-if-not-exists flathub [https://flathub.org/repo/flathub.flatpakrepo](https://flathub.org/repo/flathub.flatpakrepo)`

Note: make sure you’ve installed the RPMFusion-nonfree!  
Find more information in RPMFusion’s [Multimedia post-install page](https://rpmfusion.org/Configuration/#Multimedia_post-install)

> `sudo dnf groupupdate Multimedia`

Well I don’t like it.. here’s the terminal command for disabling it , first command if for the mouse, the second one is for the touchpad (if you are using a laptop)  
When you’re on a touch screen natural scrolling feels… natural, but it means that your mouse wheel is backwards.

> `$ gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false`  
> `$ gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false`

And if for some reason you want it back… (why?!)

> `$ gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true`  
> `$ gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true`

That’s it! Enjoy your fresh Fedora 33 installation!  
Hope you find some of the tips useful, questions? help? please comment!

Update November 22nd:  
Now that you’ve installed Fedora, how about improving your Gnome experience with [12 Must Have Gnome-Shell Extensions!](https://eftalor.medium.com/12-must-have-gnome-shell-extensions-1f04f09c4466)
OR if you want to install full blown Google-ized Chrome. If you want to install a different version, change the package from -stable to -beta or -unstable.

    sudo dnf install fedora-workstation-repositories
    
    sudo dnf config-manager --set-enabled google-chrome
    
    sudo dnf install -y google-chrome-stable

### Fedy
	sudo dnf copr enable kwizart/fedy
	
	sudo dnf install fedy -y
# VMware    
    ### Installing Dependencies

**Installing Required Packages**  
With:
    sudo dnf install kernel-headers kernel-devel gcc glibc-headers make libaio

*   ### Setting Up VMware Workstation 16 Pro Installer
    
    So now **Run VMware-Workstation Bundle**  
    Access the VMware Workstation Bundle Location:
    
    Copy
    
    cd $HOME/Downloads
    
    Give Execution Permissions:
    
    Copy
    
    chmod +x ./VMware-Workstation\*16\*.bundle
    
    Then Run the VMware Workstation Bundle:
    
    Copy
    
    sudo ./VMware-Workstation\*16\*.bundle
    
    With this Take the Time and leave the Setup to Make all required Components.
    
*   ### 5\. Starting VMware Workstation 16 Pro Installer
    
    Now **Launch VMware Workstation 16 Pro Wizard**  
    From Command Line with:
    
    Copy
    
    vmware
    
    Accept the Licenses:
    
    ![VMware Workstation 16 Pro Fedora 33 Installation - Accept Licenses](https://mediaw.tutorialforlinux.com/software/vmware/workstation/pro/16/installer/1-endUserLicense.png)
    
    ![VMware Workstation 16 Pro Fedora 33 Installation - Accept Licenses](https://mediaw.tutorialforlinux.com/software/vmware/workstation/pro/16/installer/1-endUserLicense.png)
    
      
    Next Choose if partecipating to VMware CEIP:  
    ![VMware Workstation 16 Pro Fedora 33 Installation - Customer Experience Improvement Program](https://mediaw.tutorialforlinux.com/software/vmware/workstation/pro/16/installer/2-ceipProgram.png)
    
    ![VMware Workstation 16 Pro Fedora 33 Installation - Customer Experience Improvement Program](https://mediaw.tutorialforlinux.com/software/vmware/workstation/pro/16/installer/2-ceipProgram.png)
    
      
    Possibly Insert the **License Key** if Already have One:  
    (You can always give it in a next time)  
    ![VMware Workstation 16 Pro Fedora 33 Installation - Insert License Key](https://mediaw.tutorialforlinux.com/software/vmware/workstation/pro/16/installer/3-licenseKey.png)
    
    ![VMware Workstation 16 Pro Fedora 33 Installation - Insert License Key](https://mediaw.tutorialforlinux.com/software/vmware/workstation/pro/16/installer/3-licenseKey.png)
    
      Then automatically **Start Installation** and in a few while it should be Successfully Achieved!
      
      ZF3R0-FHED2-M80TY-8QYGC-NPKYF
      
## PacketTracer on Fedora 31 Workstation

*   Log into the Fedora GNOME Desktop  
    Remove old version of PacketTracer (if necessary):  
    rm -rf /opt/pt  
    rm -rf /usr/share/applications/cisco-pt.desktop  
    rm -rf /usr/share/applications/cisco-ptsa.desktop  
    rm -rf /usr/share/icons/hicolor/48x48/apps/pt.png
    
*   Download from the netacad web site the PacketTracer\_730\_amd64.deb package.
    
*   Open a terminal :  
    mkdir -p tmp/pt800  
    copy the `ar -xv PacketTracer_800_amd64_build212_final.deb` package to tmp/pt800
    
*   We’re going to extract the deb file in this folder:  
    cd tmp/pt800  
    ar -xv PacketTracer_800_amd64_build212_final.deb
    mkdir control  
    tar -C control -Jxf control.tar.xz  
    mkdir data  
    tar -C data -Jxf data.tar.xz
    
*   Copy PacketTracer files to install it:  
    cd data  
    sudo cp -r usr /  
    sudo cp -r opt /
    
*   Configure Gnome Environment:  
    sudo xdg-desktop-menu install /usr/share/applications/cisco-pt.desktop  
    sudo xdg-desktop-menu install /usr/share/applications/cisco-ptsa.desktop  
    sudo update-mime-database /usr/share/mime  
    sudo gtk-update-icon-cache --force --ignore-theme-index /usr/share/icons/gnome  
    sudo xdg-mime default cisco-ptsa7.desktop x-scheme-handler/pttp  
    sudo ln -sf /opt/pt/packettracer /usr/local/bin/packettracer

### Chromecast Using Terminal

You can use your terminal to cast your files to a TV. You may cast local files or YouTube videos.

**_Step 1:_** Open your terminal

_**Step 2:**_ Install mkchromecast. I already have this installed, and you can install it using the following terminal command:

$ sudo apt install mkchromecast

**_Step 3:_** Enter the below command to see a list of available networks. In the top right corner, you will be able to see a new Chromecast icon. Click the icon and select your TV.

$ mkchromecast \-t

[![](https://linuxhint.com/wp-content/uploads/2020/05/4-36.png)

![](https://linuxhint.com/wp-content/uploads/2020/05/4-36.png)

](https://linuxhint.com/wp-content/uploads/2020/05/4-36.png)

If you are unable to see any devices, select the “Search for Media Streaming Devices” option.

**_Step 4:_** To cast media to the selected device, use the following commands:

For local files:

$ mkchromecast \--video \-i /home/videos/cast.mp4

You may replace “/home/videos/cast.mp4” with the path of your own local video file.

### How to Install Visual Studio Code on CentOS, RHEL, and Fedora

The procedure of installing **Visual Studio Code** on RedHat based distributions is pretty much like **Ubuntu**. Right off the bat, launch your terminal and update your system:

$ sudo dnf update

Next, import Microsoft’s GPG key using the [rpm command](https://www.tecmint.com/20-practical-examples-of-rpm-commands-in-linux/ "20 Practical Examples of RPM Commands in Linux") below:

$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

With Microsoft’s GPG key in place, proceed and create the repository file for **Visual Studio Code**:

$ sudo vim /etc/yum.repos.d/vstudio\_code.repo

Next, append the code below and save the file:

\[code\]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc

To install Visual Studio code, run the command:

$ sudo dnf install code

To use it, use the Application manager to search the **Visual Studio Code** and launch it, you will get a window as shown below.

[![Install Visual Studio Code in CentOS](https://www.tecmint.com/wp-content/uploads/2020/05/Install-Visual-Studio-Code-in-CentOS.png)

![Install Visual Studio Code in CentOS](https://www.tecmint.com/wp-content/uploads/2020/05/Install-Visual-Studio-Code-in-CentOS.png)

](https://www.tecmint.com/wp-content/uploads/2020/05/Install-Visual-Studio-Code-in-CentOS.png)

Install Visual Studio Code in CentOS

You can now proceed and start writing your code and installing your preferred extensions.
