#> Mounting Google Drive using Gnome Online Accounts in Xfce.

>	To mount Google Drive using Gnome Online Accounts / Gnome Settings (Control Center) in desktop environments such as Xfce, MATE, and others, you'll need to install the gnome-control-center and gnome-online-accounts packages. They include multiple Gnome dependencies - if you don't want this, you can check out the Google Drive OCamlFUSE option below.

Open a terminal and type this command to install them:


> sudo apt install gnome-control-center gnome-online-accounts

Gnome Settings is hidden and doesn't show up in the menu on non-Gnome desktop environments. So if you use Xfce, MATE or some other desktop environment you won't see Gnome Settings or Gnome Control Center in your menu. To run it, we'll need to use a terminal and add XDG_CURRENT_DESKTOP=GNOME before the executable, like this:

XDG_CURRENT_DESKTOP=GNOME gnome-control-center

Now go to Online Accounts, click Google and add your Google account:
Immediately after adding your Google account to Online Accounts, you should see your Google Drive folder in the file manager (Caja, Thunar or whatever file manager you may be using):

Using Google Drive OCamlFUSE to mount Google Drive in Linux

Archlinux

google-drive-ocamlfuse is available in the AUR.


> ### [](https://github.com/astrada/google-drive-ocamlfuse/wiki/Installation#installing-with-opam)Installing with OPAM
> 
> 1.  Install `OPAM` ([http://opam.ocaml.org/doc/Install.html](http://opam.ocaml.org/doc/Install.html))
>     
> 2.  Start OPAM
>     
>          opam init
>         
>     
> 3.  Update OPAM
>     
>          opam update
>         
>     
> 4.  Install the external dependencies:
>     
>          opam install depext
>          opam depext google-drive-ocamlfuse
>         
>     
> 5.  Install `google-drive-ocamlfuse`
>     
>          opam install google-drive-ocamlfuse


Now you'll have to authenticate google-drive-ocamlfuse with your Google account. To do this, run google-drive-ocamlfuse in a terminal, without appending any options, like this:

google-drive-ocamlfuse

A new tab should open in your default web browser, which asks you to allow google-drive-ocamlfuse to access your Google account. You'll need to allow it and proceed to the next step.

Next, you'll need to create an empty folder in your home directory, which will be used as your Google Drive folder. Something like GoogleDrive should do it. Note that all the instructions below assume you're using ~/GoogleDrive as your Google Drive mount point (if you use a different mount point, remember to change it in all the commands that follow).

After creating this folder in your home directory, run the command below to mount Google Drive to this folder, like this:

google-drive-ocamlfuse ~/GoogleDrive

You'll also need to add google-drive-ocamlfuse with the mount point as an argument to your startup applications. You can access your startup applications as follows:

    Xfce: launch Session and Startup from the menu, go to the Application Autostart tab and click Add

    After clicking Add, use the following:

    Name: google-drive-ocamlfuse
    Command: sh -c "google-drive-ocamlfuse ~/Google-Drive"

Instead of adding google-drive-ocamlfuse to startup, you can also automatically mount it in various ways, as explained [here](https://github.com/astrada/google-drive-ocamlfuse/wiki/Automounting).

For advanced google-drive-ocamlfuse configuration you can check out this [page.](https://github.com/astrada/google-drive-ocamlfuse/wiki/Configuration)
