## Install updates and reboot[](#install-updates-and-reboot)
---
    sudo dnf upgrade --refresh
    sudo dnf check
    sudo dnf autoremove
    sudo fwupdmgr get-devices
    sudo fwupdmgr refresh --force
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
	sudo reboot now
----
=
----
## Enable RPM Fusion free/nonfree repos

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
~sudo dnf install -y *-firmware~

# AppStream will display the RPM Fusion software in Gnome Software and KDE Discover.

sudo dnf -y groupupdate core

# The following command will adds packages for gstreamer enabled applications.

sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# This package install complement packages needed by some applications for sound and video.
sudo dnf -y groupupdate sound-and-video
=
----
# REALTEK RTL88x2B USB Linux Driver
## Manual DKMS installation

```
sudo git clone "https://github.com/RinCat/RTL88x2BU-Linux-Driver.git" /usr/src/rtl88x2bu-git
sudo sed -i 's/PACKAGE_VERSION="@PKGVER@"/PACKAGE_VERSION="git"/g' /usr/src/rtl88x2bu-git/dkms.conf
sudo dkms add -m rtl88x2bu -v git
sudo dnf -y install git dkms kernel-devel kernel-debug-devel
dkms autoinstall
```

--- 

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
------
# **Install Additional Desktop Environments**
    sudo dnf grouplist -v hidden
    sudo dnf install @cinnamon-desktop-environment @developer-workstation-environment @i3-desktop-environment @3d-printing @electronic-lab @i3 @i3-extended @platform-vmware @window-managers

    sudo dnf copr enable kwizart/fedy 
    sudo dnf install fedy -y

### Setting up and running Jupyter

First, install essential packages for Jupyter ([using](https://fedoramagazine.org/howto-use-sudo/) _[sudo](https://fedoramagazine.org/howto-use-sudo/)_):

	sudo dnf install -y python3-notebook mathjax sscg

You might want to install additional and optional Python modules commonly used by data scientists:

	sudo dnf install -y python3-seaborn python3-lxml python3-basemap python3-scikit-image python3-scikit-learn python3-sympy python3-dask+dataframe python3-nltk

Set a password to log into Notebook web interface and avoid those long tokens. Run the following command anywhere on your terminal:

	mkdir -p $HOME/.jupyter  
	jupyter notebook password

Now, type a password for yourself. This will create the file _$HOME/.jupyter/jupyter\_notebook\_config.json_ with your encrypted password.

Next, prepare for SSLby generating a self-signed HTTPS certificate for Jupyter’s web server:

	cd $HOME/.jupyter; sscg

Finish configuring Jupyter by editing your _$HOME/.jupyter/jupyter\_notebook\_config.json_ file. Make it look like this:

{  
   "NotebookApp": {  
     "password": "sha1:abf58...87b",  
     "ip": "\*",  
     "allow\_origin": "\*",  
     "allow\_remote\_access": true,  
     "open\_browser": false,  
     "websocket\_compression\_options": {},  
     "certfile": "/home/josh/.jupyter/service.pem",  
     "keyfile": "/home/josh/.jupyter/service-key.pem",  
     "notebook\_dir": "/home/josh/Notebooks"  
   }  
} 

The parts in red must be changed to match your folders. Parts in blue were already there after you created your password. Parts in green are the crypto-related files generated by _sscg_.

Create a folder for your notebook files, as configured in the _notebook\_dir_ setting above:

 	mkdir $HOME/Notebooks

Now you are all set. Just run Jupyter Notebook from anywhere on your system by typing:

	jupyter notebook

Or add this line to your _$HOME/.bashrc_ file to create a shortcut command called _jn_:

	alias jn='jupyter notebook'

After running the command _jn_, access _https://your-fedora-host.com:8888_ from any browser on the network to see the Jupyter user interface. You’ll need to use the password you set up earlier. Start typing some Python code and markup text. This is how it looks:

![](https://avi.alkalay.net/articlefiles/2018/07/jupyter-fedora.png)

Jupyter with a simple notebook

In addition to the IPython environment, you’ll also get a web-based Unix terminal provided by _terminado_. Some people might find this useful, while others find this insecure. You can disable this feature in the config file.

## JupyterLab — the next generation of Jupyter

JupyterLab is the next generation of Jupyter, with a better interface and more control over your workspace. It’s currently not RPM-packaged for Fedora at the time of writing, but you can use _pip_ to get it installed easily:

	pip3 install jupyterlab --user  
	jupyter serverextension enable --py jupyterlab  

Then run your regular _jupiter notebook_ command or _jn_ alias. JupyterLab will be accessible from _http://your-linux-host.com:8888/**lab**_.


# Cherrytree
---------

## Quick Enable

	dnf copr enable bcotton/cherrytree
 
### Description ---- 
<i> ==== Hierarchical note taking application. ====

This is a stop-gap since cherrytree was removed from F31 but is a python2 application that upstream is rewriting in C++.

The old python2 version will not work on Fedora 32 and beyond due to missing dependencies that quickly became more work than I was willing to take on. The C++ rewrite is available as cherrytree-future for now. I intend to bring that into the official repos when upstream is ready to call it released.

<b> Installation Instructions:</b> 

* To install, enable this COPR repo:

		sudo dnf copr enable bcotton/cherrytree
	
* Then install cherrytree: 

		sudo dnf install cherrytree

Or! Install cherrytree-future (available on F32 and beyond. Older builds are available for F31, see comments below): sudo dnf install cherrytree-future
</i>

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
    

## **Installing Required Packages**  

With:
    
	sudo dnf install kernel-headers kernel-devel gcc glibc-headers make libaio

* ### Setting Up VMware Workstation 16 Pro Installer

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
## Fedora Media Writer – The fastest way to create Live-USB boot media

### For Fedora

sudo dnf install liveusb-creator -y

How to List Installed Packages with YUM
---------------------------------------

YUM stands for Yellowdog Updater, Modified. It is an updated package manager that allows you to install, remove, update, view, or search software packages.

Use the following **`yum`** command  to display all installed packages:

    sudo yum list installed

To check if a specific package is installed with YUM, filter the output with the [**`grep`** command](https://phoenixnap.com/kb/grep-command-linux-unix-examples):

    sudo yum list installed | grep xorg

![terminal yum list packages command with grep](https://phoenixnap.com/kb/wp-content/uploads/2019/04/yum-command-list-grep-xorg.jpg)

![terminal yum list packages command with grep](https://phoenixnap.com/kb/wp-content/uploads/2019/04/yum-command-list-grep-xorg.jpg)

  
To display the details on a particular package with YUM:

    yum info httpd

![terminal with yum info command](https://phoenixnap.com/kb/wp-content/uploads/2019/04/yum-command-info.jpg)

![terminal with yum info command](https://phoenixnap.com/kb/wp-content/uploads/2019/04/yum-command-info.jpg)

  
YUM can also output the full package list to a file:

    sudo yum list installed > listed_packages.txt

This file can be copied to another system to duplicate the installed packages:

    sudo yum –y install $(cat listed_packages.txt)

*   The **`–y`** option answers _yes_ to all installation prompts
*   The **`cat`** command concatenates the contents of the file into the yum install command

For more information on the yum command, use **`yum ––help`.**

List Installed Packages with RPM
--------------------------------

RPM stands for RedHat Package Manager. It comes as standard with most Red-Hat-based Linux operating systems, such as CentOS and Fedora.

To display a list of installed packages, enter the following in a terminal window:

    sudo rpm –qa

*   The **`–q`** option means query
*   The **`–a`** option means all

To list packages by installation date, enter:

    sudo rpm –qa ––last

Search for a package by name using:

    sudo rpm –qa | grep –i httpd

This command returns results for the Apache software.

Output the list of packages to a file by entering the following:

    sudo rpm –qa > listed_packages.txt

This command saves a copy of the list in a text file called _listed\_packages.txt_ in the current working directory.

Display information about a particular package:

    rpm –qi httpd

*   The **`–q`** option stands for query
*   The **`–i`** option stands for info

Count the total number of packages installed:

    sudo rpm –qa | wc –l

*   The **`wc`** command creates a word count
*   The **`–l`** option counts the number of lines

![terminal with rpm wc command](https://phoenixnap.com/kb/wp-content/uploads/2019/04/rpm-command-list-packages.jpg)

![terminal with rpm wc command](https://phoenixnap.com/kb/wp-content/uploads/2019/04/rpm-command-list-packages.jpg)

RPM lists packages by their package name and revision number. Text-wrapping can make this tool harder to read. Use the **`rpm ––help`** command for more options, or refer to the documentation.

List Installed Packages with yum-utils
--------------------------------------

**Yum-utils** is a software package that adds functionality to the standard YUM package manager.

To install the **yum-utils** software package enter:

    sudo yum –y install yum-utils

List all installed packages with the **`repoquery`** command:

    sudo repoquery –a ––installed

The **yum-utils** package uses [yum repositories](https://phoenixnap.com/kb/create-local-yum-repository-centos) to pull information.


[MeshLab](http://meshlab.sourceforge.net/) (

meshlab

package) or [ADMeshGUI](https://github.com/admesh/ADMeshGUI) (available from a [Copr repository](https://copr.fedoraproject.org/coprs/churchyard/admesh/)).

![ADMeshGUI with our STL file](https://fedoramagazine.org/wp-content/uploads/2015/07/admeshgui.png)

ADMeshGUI with our STL file

_**Note:** OpenSCAD, as well as STL file format, uses no units. In the 3D printing area, the numbers used are usually considered millimeters, although you might find some files online using some non-standard units such as inches._

### Slicing to layers

For the object to be printed it has to be sliced to layers and paths for the 3D printer’s nozzle. There are various apps available in Fedora capable of doing it, one of the most famous tools for this is [Slic3r](http://slic3r.org/) (package

slic3r

, [newer version available from Copr](https://copr.fedoraproject.org/coprs/churchyard/slic3r-latest/)).

[![Slic3r with our STL file loaded](https://fedoramagazine.org/wp-content/uploads/2015/07/slic3r-1024x499.png)](https://fedoramagazine.org/wp-content/uploads/2015/07/slic3r.png)

Slic3r with our STL file loaded

For right result, it is crucial to have the correct slicer settings for your printer and material. You should obtain those from the whoever you’ve obtained your 3D printer (or just create your settings if you have built one yourself). When you select the right settings, just click _Export G-code…_ to generate file with instructions for the printer.

![Slic3r 1.2.9 from Copr repository with G-code preview](https://fedoramagazine.org/wp-content/uploads/2015/07/slic3r129.png)

Slic3r 1.2.9 from Copr repository with G-code preview

The [G-Code](https://en.wikipedia.org/wiki/G-code) file is just a plain text with loads of numerical control commands. Here is a snip:

G21 ; set units to millimeters
M107
M190 S60 ; wait for bed temperature to be reached
M109 S195
G28 ; home all axes
G92 E0  ;reset extruder
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion
G1 F1800.000 E-1.00000
G1 Z0.300 F7800.000
G1 X77.706 Y77.667 F7800.000
G1 E1.00000 F1800.000
G1 X78.476 Y76.924 E0.07695 F1800.000
G1 X79.209 Y76.261 E0.07110
G1 X79.963 Y75.622 E0.07108
G1 X80.743 Y75.000 E0.07179
G1 X81.533 Y74.412 E0.07080
G1 X82.348 Y73.843 E0.07150
G1 X83.178 Y73.301 E0.07131
G1 X84.025 Y72.786 E0.07133
G1 X84.891 Y72.296 E0.07151
G1 X85.766 Y71.836 E0.07110
G1 X86.655 Y71.404 E0.07115
G1 X87.562 Y70.998 E0.07148
...

### Printing

With the gcode file, all that’s left to do is to feed those numerical control commands to the 3D printer. Some printers might have the ability to print from an SD card, others have to be connected by an USB cable during the entire print. To control you printer from Fedora, you might use Pronterface tool from [Printrun](https://github.com/kliment/Printrun) (install the

pronterface

or

printrun

package). To communicate with the printer, you’re user has to be in the

dialout

group.

Once Pronterface is connected, user can load the G-code file and start the print. When you are currently printing, be sure not to accidentally suspend your computer by closing the lid.

![Pronterface: The print just started](https://fedoramagazine.org/wp-content/uploads/2015/07/pronterface.png)

Pronterface: The print just started

![SolveSpace](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_60,h_60/https://dashboard.snapcraft.io/site_media/appmedia/2020/01/solvespace-256.png)

# SolveSpace

SolveSpace Publisher

-   SolveSpace Publisher
-   [Art and Design](https://snapcraft.io/search?category=art-and-design)

[Install snap](https://snapcraft.io/install/solvespace/fedora#install)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/ex-case.jpg)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/ex-case-outline.png)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/linkage-whitworth-solid.png)

![SolveSpace](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_60,h_60/https://dashboard.snapcraft.io/site_media/appmedia/2020/01/solvespace-256.png)

# SolveSpace

SolveSpace Publisher

-   SolveSpace Publisher
-   [Art and Design](https://snapcraft.io/search?category=art-and-design)

[Install snap](https://snapcraft.io/install/solvespace/fedora#install)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/ex-case.jpg)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/ex-case-outline.png)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/linkage-whitworth-solid.png)

![SolveSpace](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_60,h_60/https://dashboard.snapcraft.io/site_media/appmedia/2020/01/solvespace-256.png)

# SolveSpace

SolveSpace Publisher

-   SolveSpace Publisher
-   [Art and Design](https://snapcraft.io/search?category=art-and-design)

[Install snap](https://snapcraft.io/install/solvespace/fedora#install)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/ex-case.jpg)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/ex-case-outline.png)

![](https://res.cloudinary.com/canonical/image/fetch/q_auto,f_auto,w_430/https://dashboard.snapcraft.io/site_media/appmedia/2019/03/linkage-whitworth-solid.png)

# Install ![cd](https://github.githubassets.com/images/icons/emoji/unicode/1f4bf.png)

-   Homebrew: `brew install gping`
-   Linux (Homebrew): `brew install orf/brew/gping`
-   CentOS (and other distributions with an old glibc): Download the MUSL build from the latest release
-   Windows/ARM:
    -   Scoop: `scoop install gping`
    -   Chocolatey: `choco install gping`
    -   Download the latest release from [the github releases page](https://github.com/orf/gping/releases)
-   Fedora ([COPR](https://copr.fedorainfracloud.org/coprs/atim/gping/)): `sudo dnf copr enable atim/gping -y && sudo dnf install gping`
-   Cargo (**This requires `rustc` version 1.44.0 or greater**): `cargo install gping`
-   Arch Linux: `pacman -S gping`
-   Ubuntu/Debian ([Azlux's repo](http://packages.azlux.fr/)):

echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install gping

# [](https://github.com/orf/gping#usage-saxophone)

# Install ![cd](https://github.githubassets.com/images/icons/emoji/unicode/1f4bf.png)

-
## 1\. Before NVIDIA drivers installation

### 1.1 Check is your NVIDIA card supported

```bash
lspci |grep -E "VGA|3D"

## Example outputs ##
01:00.0 VGA compatible controller: NVIDIA Corporation TU106 [GeForce RTX 2060 Rev. A] (rev a1)
```

[List of Supported NVIDIA GPU Products](http://download.nvidia.com/XFree86/Linux-x86_64/460.80/README/supportedchips.html "List of Supported NVIDIA GPU Products"), check best driver for your card.

If you see multiple VGA controllers, then check next step and sometimes you might see example Intel VGA controller which have nothing to do with Optimus, normally you can go to BIOS and simply disable it.

### 1.2 NVIDIA Optimus Technology

If your **lspci |grep -E “VGA|3D”** output looks like following:

```bash
00:02.0 VGA compatible controller: Intel Corporation 2n Generation Core Processor Family Integrated Graphics Controller (rev 09)
01:00.0 VGA compatible controller: NVIDIA Corporation GF106 [GeForce GT 555M SDDR3] (rev a1)
```

Or

```bash
00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller (rev 06)
01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 750M] (rev a1)
```

Or you know that your computer have [NVIDIA Optimus Technology](https://www.nvidia.com/object/optimus_technology.html "NVIDIA Optimus Technology"), and **it is impossible to turn Intel Graphics / NVIDIA Optimus off in the BIOS then this guide might not work for you** and it’s not tested. You should read this [NVIDIA Optimus page](http://download.nvidia.com/XFree86/Linux-x86_64/460.80/README/optimus.html) first and maybe check [Bumblebee Project](http://bumblebee-project.org/) or [NVIDIA XRun Project](https://github.com/Witko/nvidia-xrun).

### 1.3 Disable UEFI Secure Boot or Check Howto Sign NVIDIA Kernel Module

If you have UEFI Secure Boot enabled, then you have to disable Secure Boot or [sign your NVIDIA kernel module](http://download.nvidia.com/XFree86/Linux-x86_64/460.80/README/installdriver.html#modulesigning).

## 2\. Install NVIDIA proprietary drivers on Fedora 33/32/31/30/29 and disable the nouveau driver

### 2.1 Download NVIDIA Installer Package

Go to [http://www.nvidia.com/Download/Find.aspx?lang=en-us](https://www.nvidia.com/Download/Find.aspx?lang=en-us) and find latest version of installer package. When you use browser this is normally downloaded /home/<username>/Downloads/NVIDIA-Linux-xxxx.run location.

#### Tested versions with 5.11+ / 5.10+ / 5.9+ kernels:

Fedora 34

Fedora 33

Fedora 32

Fedora 31/30

465.27 (April 29, 2021)

465.27 (April 29, 2021)

465.27 (April 29, 2021)

465.27 (April 29, 2021)

460.80 (May 11, 2021)

460.80 (May 11, 2021)

460.80 (May 11, 2021)

460.80 (May 11, 2021)

450.119.03 (April 19, 2021)

450.119.03 (April 19, 2021)

450.119.03 (April 19, 2021)

450.119.03 (April 19, 2021)

435.21 (August 29, 2019)

435.21 (August 29, 2019)

435.21 (August 29, 2019)

435.21 (August 29, 2019)

418.113 (November 5, 2019)

418.113 (November 5, 2019)

418.113 (November 5, 2019)

418.113 (November 5, 2019)

390.143 (April 19, 2021)

390.143 (April 19, 2021)

390.143 (April 19, 2021)

390.143 (April 19, 2021)

340.108 (December 23, 2019)

340.108 (December 23, 2019)

340.108 (December 23, 2019)

340.108 (December 23, 2019)

**Note 340.108 users:** 340.108 on Fedora 34/33/32/31 Kernel 5.11/5.10/5.9 needs a patched version ([Download inttf NVIDIA patcher and patch NVIDIA-Linux-x86\_64-340.108 for Kernel 5.11+ / 5.10+ / 5.9+](https://www.if-not-true-then-false.com/2020/inttf-nvidia-patcher/)).

**Note 418.113 and 435.21 users:** These are not official NVIDIA LEGACY drivers, but there is example GeForce GTX 1650 Mobile card which is not supported by older or newer drivers. ([Download inttf NVIDIA patcher and patch NVIDIA-Linux-x86\_64-418.113 and NVIDIA-Linux-x86\_64-435.21 for Kernel 5.11+ / 5.10+ / 5.9+](https://www.if-not-true-then-false.com/2020/inttf-nvidia-patcher/))

**Note Older Fedora users:** If you have any problems with GDM (black screen). You can easily [switch Display Manager example to LXDM, LightDM, SDDM or KDM](https://www.if-not-true-then-false.com/2018/fedora-switch-display-manager/).

### 2.2 Make NVIDIA installer executable

```bash
chmod +x /path/to/NVIDIA-Linux-*.run
```

### 2.3 Change root user

```bash
su -
## OR ##
sudo -i
```

### 2.4 Make sure that you system is up-to-date and you are running latest kernel

```bash
## Fedora 34/33/32/31/30 ##
dnf update
```

**After update reboot your system and boot using latest kernel:**

```bash
reboot
```

### 2.5 Install needed dependencies

```bash
## Fedora 34/33/32/31/30 ##
dnf install kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
```

### 2.6 Disable nouveau

#### 2.6.1 Create or edit /etc/modprobe.d/blacklist.conf

Append ‘blacklist nouveau’

```bash
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
```

#### 2.6.2 Edit /etc/default/grub

Append ‘rd.driver.blacklist=nouveau’ to end of ‘GRUB\_CMDLINE\_LINUX=”…”‘.

```bash
## Example row with Fedora 34 BTRFS ##
GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau"

## OR with LVM ##
GRUB_CMDLINE_LINUX="rd.lvm.lv=fedora/swap rd.lvm.lv=fedora/root rhgb quiet rd.driver.blacklist=nouveau"
```

#### 2.6.3 Update grub2 conf

**Fedora 34**

```bash
## BIOS and UEFI ##
grub2-mkconfig -o /boot/grub2/grub.cfg
```

**Fedora 33/32/31/30**

```bash
## BIOS ##
grub2-mkconfig -o /boot/grub2/grub.cfg

## UEFI ##
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```

#### 2.6.4 Remove xorg-x11-drv-nouveau

```bash
## Fedora 34/33/32/31/30 ##
dnf remove xorg-x11-drv-nouveau
```

#### 2.6.5 Generate initramfs

```bash
## Backup old initramfs nouveau image ##
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img
 
## Create new initramfs image ##
dracut /boot/initramfs-$(uname -r).img $(uname -r)
```

### 2.7 Reboot to runlevel 3

**Note:** You don’t have Desktop/GUI on runlevel 3. Make sure that you have some access to end of guide. (Open it on mobile browser, Print it, use lynx/links/w3m, save it to text file).

```bash
systemctl set-default multi-user.target

reboot
```

**OR alternatively you can [change the runlevel on GRUB2 adding one additional parameter](https://www.if-not-true-then-false.com/2012/howto-change-runlevel-on-grub2/). [Quick guide howto change runlevel on GRUB2](https://www.if-not-true-then-false.com/2012/howto-change-runlevel-on-grub2/). If you use this method, then don’t set multi-user.target and don’t set graphical.target on step 2.9 (just reboot).**

### 2.8 Install NVIDIA proprietary drivers for GeForce 6/7 & GeForce 8/9/200/300 & GeForce 400/500/600/700/800/900/10/20 series cards

#### 2.8.1 Log in as root user

Or alternatively change root user (you shouldn’t have nouveau and xorg loaded)

```bash
su -
## OR ##
sudo -i
```

#### 2.8.2 Run NVIDIA Binary

Following command executes driver install routine. Use full file name command if you have multiple binaries on same directory.

```bash
./NVIDIA-Linux-*.run

## OR full path / full file name ##

Downloads/NVIDIA-Linux-x86_64-465.27.run

Downloads/NVIDIA-Linux-x86_64-460.80.run

Downloads/NVIDIA-Linux-x86_64-450.119.03.run

./NVIDIA-Linux-x86_64-435.21-patched-kernel-5.11.run

./NVIDIA-Linux-x86_64-418.118-patched-kernel-5.11.run

./NVIDIA-Linux-x86_64-390.143.run

/path/to/NVIDIA-Linux-x86_64-340.108-patched-kernel-5.11.run
```
**Note:** [If you get libglvnd error, then abort installation and try this](https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/4/#libglvnd-error). Also “Install and overwrite existing files” works, but fixing this error is more clean way to install NVIDIA Drivers.

### 2.9 All Is Done and Then Reboot Back to Runlevel 5

```bash
systemctl set-default graphical.target

reboot
```

### 2.10 VDPAU/VAAPI support

To enable video acceleration support for your player (Note: you need Geforce 8 or later).

```bash
## Fedora 34/33/32/31/30 ##
dnf install vdpauinfo libva-vdpau-driver libva-utils
```

----
## Oh My Zsh

1.  Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)
    
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH\_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
2.  Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):
    
    plugins=(zsh-autosuggestions)
    
3.  Start a new terminal session.
    

## [](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#manual-git-clone)

## Oh My Zsh

1.  Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)
    
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH\_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
2.  Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):
    
    plugins=(zsh-autosuggestions)
    
3.  Start a new terminal session.
    

## [](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#manual-git-clone)
----
#### [oh-my-zsh](http://github.com/robbyrussell/oh-my-zsh)

-   Clone the repository inside your oh-my-zsh repo:
    
    ```
      git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    ```
    
-   Enable it in your `.zshrc` by adding it to your plugin list and reloading the completion:
    
    ```
      plugins=(… zsh-completions)
      autoload -U compinit && compinit
    ```
    

### [](https://github.com/zsh-users/zsh-completions#manual-installation)

#### [oh-my-zsh](http://github.com/robbyrussell/oh-my-zsh)

-   Clone the repository inside your oh-my-zsh repo:
    
    ```
      git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    ```
    
-   Enable it in your `.zshrc` by adding it to your plugin list and reloading the completion:
    
    ```
      plugins=(… zsh-completions)
      autoload -U compinit && compinit
    ```
    

### [](https://github.com/zsh-users/zsh-completions#manual-installation)
----
### In your ~/.zshrc

Simply clone this repository and source the script:

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \>> ${ZDOTDIR:-$HOME}/.zshrc

Then, enable syntax highlighting in the current interactive shell:

source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

If `git` is not installed, download and extract a snapshot of the latest development tree from:

```
https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz
```

Note the `source` command must be **at the end** of `~/.zshrc`.

### [](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager)

### In your ~/.zshrc

Simply clone this repository and source the script:

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \>> ${ZDOTDIR:-$HOME}/.zshrc

Then, enable syntax highlighting in the current interactive shell:

source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

If `git` is not installed, download and extract a snapshot of the latest development tree from:

```
https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz
```

Note the `source` command must be **at the end** of `~/.zshrc`.

### [](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager)

### In your ~/.zshrc

Simply clone this repository and source the script:

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \>> ${ZDOTDIR:-$HOME}/.zshrc

Then, enable syntax highlighting in the current interactive shell:

source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

If `git` is not installed, download and extract a snapshot of the latest development tree from:

```
https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz
```

Note the `source` command must be **at the end** of `~/.zshrc`.

### [](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager)

### In your ~/.zshrc

Simply clone this repository and source the script:

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \>> ${ZDOTDIR:-$HOME}/.zshrc

Then, enable syntax highlighting in the current interactive shell:

source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

If `git` is not installed, download and extract a snapshot of the latest development tree from:

```
https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz
```

Note the `source` command must be **at the end** of `~/.zshrc`.

### [](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager)
