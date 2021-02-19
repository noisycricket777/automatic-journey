># Install updates and reboot
====================================
		
		sudo dnf upgrade --refresh
		
		sudo dnf checknn
		
		sudo dnf autoremove
		
		sudo fwupdmgr get-devices
		
		sudo fwupdmgr refresh --force
    	
		sudo fwupdmgr get-updates
    	
		sudo fwupdmgr update
    	
		sudo reboot now

># Enable RPM Fusion free/non-free repos
====================================================

		sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

----
* ###### To enable the RPM Fusion free and non-free repositories. Afterwards run.
---------------------------------------------------------------------------
	
		sudo dnf upgrade --refresh
    	
		sudo dnf groupupdate core
    	
		sudo dnf install -y rpmfusion-free-release-tainted
    	
		sudo dnf install -y dnf-plugins-core
-----
* ###### To enable DVD playback in Fedora, enable the Tainted RPM Fusion repository. After enabling, install the libdvdcss package.
	
		sudo dnf install -y rpmfusion-free-release-tainted
		
		sudo dnf install -y libdvdcss

---------
* ###### The Non-free Tainted repository contains software that may have ambiguous copyright or distribution rules. The firmware command will install additional drivers that help with hardware compatibility.

		sudo dnf install -y rpmfusion-nonfree-release-tainted
		
		sudo dnf install -y *-firmware
---
* ##### AppStream will display the RPM Fusion software in Gnome Software and KDE Discover.

		sudo dnf -y groupupdate core
---
* ##### The following command will adds packages for gstreamer enabled applications.

		sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
---
* ##### This package install complement packages needed by some applications for sound and video.

		sudo dnf -y groupupdate sound-and-video
----

># Flatpak support
=====================


Flatpak is installed by default on Fedora Workstation, but one needs to enable the Flathub store:

		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    
		flatpak update



># Snap support
====================

* Enabling snap support boils down to running the following commands:

		sudo dnf install -y snapd
    
		sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
    
		sudo reboot now


* The restart is needed to ensure snap’s paths are updated correctly. After the reboot, check whether there are any updates:

		sudo snap refresh

>## Gnome Tweak Tool makes it easy to modify the system
=====================================================

		sudo dnf install -y gnome-tweak-tool

>## VLC is a popular media player
======================================
		
		sudo dnf install -y vlc
-----
* ##### Additional codecs to cover multimedia

		sudo dnf install gstreamer1-{plugin-crystalhd,ffmpeg,plugins-{good,ugly,bad{,-free,-nonfree,-freeworld,-extras}{,-extras}}} libmpg123 lame-libs --setopt=strict=0 -y
---
>## GParted – partition management utility
===================================================

		sudo dnf -y install gparted

># Improved fonts. 
==============================

* ##### Enable the better fonts repo and then install the fonts.

		sudo dnf copr enable dawid/better_fonts

		sudo dnf install -y fontconfig-enhanced-defaults fontconfig-font-replacements

># Wine 
### Step 1: Add WineHQ repository
----------------------------------

**Start by adding WineHQ repository with the latest stable packages for Wine.**

    	sudo dnf -y install dnf-plugins-core
    	
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/32-winehq.repo

### Step 2: Install Wine 6 on Fedora 33/32/31/30/29
---------------------------------------------------

**Stable branch** – (**_Recommended_**)

    	sudo dnf -y install winehq-stable

># Install Additional Desktop Environments
======================================================

		sudo dnf grouplist -v hidden
	
		sudo dnf install @cinnamon-desktop-environment @cinnamon-desktop @enlightenment-desktop @electronic-lab @platform-vmware

> # Install Fedy
==============

		sudo dnf copr enable kwizart/fedy
	
		sudo dnf install fedy -y






-----
**Tip**: to change it temporarily you can simply invoke _ctrl + l_

> Before:

![Image for post](https://miro.medium.com/max/60/1*Ueel8HRnSOlr2myojVua1Q.png?q=20)

![Image for post](https://miro.medium.com/max/1834/1*Ueel8HRnSOlr2myojVua1Q.png)

After:

![Image for post](https://miro.medium.com/max/60/1*PV4chMyNZ9tZxvj4Vln5Ig.png?q=20)

![Image for post](https://miro.medium.com/max/1930/1*PV4chMyNZ9tZxvj4Vln5Ig.png)

Open a terminal and invoke:

		gsettings set org.gnome.nautilus.preferences always-use-location-entry true

		sudo dnf install [https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-33.noarch.rpm](https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-33.noarch.rpm)`

		sudo dnf install [https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-33.noarch.rpm](https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-33.noarch.rpm)`
----
** DNF is great and have come a long way since the days of Yum, it can be even better by enabling 3 of its plugins:

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

		sudo dnf install guvcview
-----
> #### Install full blown Google-ized Chrome. If you want to install a different version, change the package from -stable to -beta or -unstable.

	   	sudo dnf install fedora-workstation-repositories

   		sudo dnf config-manager --set-enabled google-chrome

   		sudo dnf install -y google-chrome-stable

># VMware    
   
   * **Installing Required Packages**
   
	sudo dnf install kernel-headers kernel-devel gcc glibc-headers make libaio
		
* **Setting Up VMware Workstation 16 Pro Installer**

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

> ## Fedora Media Writer – The fastest way to create Live-USB boot me
### For Fedora

sudo dnf install liveusb-creator -y

>### Setting up and running Jupyter

First, install essential packages for Jupyter ([using](https://fedoramagazine.org/howto-use-sudo/) _[sudo](https://fedoramagazine.org/howto-use-sudo/)_):

$ sudo dnf install python3-notebook mathjax sscg

You might want to install additional and optional Python modules commonly used by data scientists:

$ sudo dnf install python3-seaborn python3-lxml python3-basemap python3-scikit-image python3-scikit-learn python3-sympy python3-dask+dataframe python3-nltk

Set a password to log into Notebook web interface and avoid those long tokens. Run the following command anywhere on your terminal:

$ mkdir -p $HOME/.jupyter  
$ jupyter notebook password

Now, type a password for yourself. This will create the file _$HOME/.jupyter/jupyter\_notebook\_config.json_ with your encrypted password.

Next, prepare for SSLby generating a self-signed HTTPS certificate for Jupyter’s web server:

$ cd $HOME/.jupyter; sscg

Finish configuring Jupyter by editing your _$HOME/.jupyter/jupyter\_notebook\_config.json_ file. Make it look like this:

{  
"NotebookApp": {  
"password": "sha1:abf58...87b",  
"ip": "\*",  
"allow\_origin": "\*",  
"allow\_remote\_access": true,  
"open\_browser": false,  
"websocket\_compression\_options": {},  
"certfile": "/home/aviram/.jupyter/service.pem",  
"keyfile": "/home/aviram/.jupyter/service-key.pem",  
"notebook\_dir": "/home/aviram/Notebooks"  
}  
}

The parts in red must be changed to match your folders. Parts in blue were already there after you created your password. Parts in green are the crypto-related files generated by _sscg_.

Create a folder for your notebook files, as configured in the _notebook\_dir_ setting above:

$ mkdir $HOME/Notebooks

Now you are all set. Just run Jupyter Notebook from anywhere on your system by typing:

$ jupyter notebook

Or add this line to your _$HOME/.bashrc_ file to create a shortcut command called _jn_:

alias jn='jupyter notebook'

After running the command _jn_, access _https://your-fedora-host.com:8888_ from any browser on the network to see the Jupyter user interface. You’ll need to use the password you set up earlier. Start typing some Python code and markup text. This is how it looks:

![](https://avi.alkalay.net/articlefiles/2018/07/jupyter-fedora.png)

Jupyter with a simple notebook

In addition to the IPython environment, you’ll also get a web-based Unix terminal provided by _terminado_. Some people might find this useful, while others find this insecure. You can disable this feature in the config file.

JupyterLab — the next generation of Jupyter
-------------------------------------------

JupyterLab is the next generation of Jupyter, with a better interface and more control over your workspace. It’s currently not RPM-packaged for Fedora at the time of writing, but you can use _pip_ to get it installed easily:

$ pip3 install jupyterlab --user  
$ jupyter serverextension enable --py jupyterlab  

Then run your regular _jupiter notebook_ command or _jn_ alias. JupyterLab will be accessible from _http://your-linux-host.com:8888/**lab**_.

># Gping 

### Installation instructions

The [repo](https://copr.fedorainfracloud.org/coprs/atim/gping) currently provides gping for Fedora 32, 33, and Fedora Rawhide as well as for EPEL 7 and 8. To install it, use these commands:

`sudo dnf copr enable atim/gping`
`sudo dnf install gping`

> # Blanket
-------

[Blanket](https://github.com/rafaelmardojai/blanket) is an application for playing background sounds, which may potentially improve your focus and increase your productivity. Alternatively, it may help you relax and fall asleep in a noisy environment. No matter what time it is or where you are, Blanket allows you to wake up while birds are chirping, work surrounded by friendly coffee shop chatter or distant city traffic, and then sleep like a log next to a fireplace while it is raining outside. Other popular choices for background sounds such as pink and white noise are also available.

[![Blanket](https://github.com/FrostyX/fedora-magazine/raw/main/img/blanket.png)](https://github.com/FrostyX/fedora-magazine/blob/main/img/blanket.png)

### [](https://github.com/FrostyX/fedora-magazine/blob/main/2020-december.md#installation-instructions)Installation instructions

The [repo](https://copr.fedorainfracloud.org/coprs/tuxino/blanket/) currently provides Blanket for Fedora 32 and 33. To install it, use these commands:

`sudo dnf copr enable tuxino/blanket`
`sudo dnf install blanket`

> # Bottom

A cross-platform graphical process/system monitor with a customizable interface and a multitude of features. Supports Linux, macOS, and Windows. Inspired by both [gtop](https://github.com/aksakalli/gtop) and [gotop](https://github.com/cjbassi/gotop).

[![Quick demo recording showing off searching, expanding, and process killing.](/ClementTsang/bottom/raw/master/assets/demo.gif)](/ClementTsang/bottom/blob/master/assets/demo.gif) _Theme based on [gruvbox](https://github.com/morhetz/gruvbox)_ (`--color gruvbox`). _Font is [IBM Plex Mono](https://www.ibm.com/plex/), terminal is [Kitty](https://sw.kovidgoyal.net/kitty/)._
##### Description

A cross-platform graphical process/system monitor with a customizable interface and a multitude of features. Supports Linux, macOS, and Windows. Inspired by both gtop and gotop.

##### Installation Instructions

    sudo dnf copr enable atim/bottom -y
    sudo dnf install bottom
	
> ##
Hierarchical note taking application.

This is a stop-gap since cherrytree was removed from F31 but is a python2 application that upstream is rewriting in C++.

The old python2 version will not work on Fedora 32 and beyond due to missing dependencies that quickly became more work than I was willing to take on. The C++ rewrite is available as `cherrytree-future` for now. I intend to bring that into the official repos when upstream is ready to call it released.

>## Cherrytree 
#### Installation Instructions
---------

To install, enable this COPR repo:

	sudo dnf copr enable bcotton/cherrytree
	
Then install cherrytree:

	sudo dnf install cherrytree

Or! Install cherrytree-future (available on F32 and beyond. Older builds are available for F31, see comments below): 

	sudo dnf install cherrytree-future

For questions or help, file an [issue on GitHub](https://github.com/funnelfiasco/copr-cherrytree/issues) or comment on the [Discussion thread](https://discussion.fedoraproject.org/t/bcotton-cherrytree/10617)