## LabWC-dotfiles

The version used in this installation is [Debian 13 Live XFCE](https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-13.0.0-amd64-xfce.iso)

<div align="center">

  ![imgs](/images/screenshot.png)

</div>

## Installation

Install all of the [required packages](#required-packages). Then, run the install script.

```
chmod +x install.sh
./install.sh
```

## Included Scripts

#### Scripts used by Waybar

`GrimShot.sh` = Screenshot

`LabwcTheme.sh`= Theme Changer

`LockScreen.sh` = Screen locker

`Volume.sh` = Volume manager

`xupdate` Search and apply updates

**Trick for Workspaces on Waybar**

```
WSpaces.sh 
wsactive1.sh
wsactive2.sh
wsactive3.sh
wsactive4.sh
wstmp.sh
```

#### Scripts used by LabWC

`Waybar.sh` = Start waybar

`Labcmd.sh` = Show LabWC active command keybinds

`WpSel.sh` = Change Wallpaper (create a directory ~/Pictures/Wallpapers and copy your images inside)

`ScreenShot.sh` = Screenshooter

`wofi-light.sh` = Launch wofi
 
`ShowDesk.sh` = Minimize all windows (require: [wlrctl](https://git.sr.ht/~brocellous/wlrctl))

`update-lwmenu.sh` = Launch update-menu.sh saving to ~/config/labwc/menu.xml 

`update-menu.sh` = Update menu with presets (require: [labwc-menu-generator](https://github.com/labwc/labwc-menu-generator.git))

`WayStyle.sh` = Change waybar style

`WofiEdit.sh` = Launch advanced settings
 
`reload.sh` = Reload labwc configuration

`temagtk.sh` = Load gtk theme settings at startup

`temaico.sh` = Load icons settings at startup

`getnf` = Install Nerd Fonts needed for Wayland icons (Hack - JetBrainsMono)

## Required Packages
1. Install the packages:

`
sudo apt install labwc dunst swaylock swaybg rofi waybar wlogout wofi copyq wlsunset foot micro wtype pipewire grim slurp wl-clipboard jq libnotify-bin nala imagemagick curl
`

2. Download and install the [Themes LabWC](https://github.com/Jolmas/LabWC.git)
3. Download and install the [MacTahoe Icons](https://github.com/vinceliuice/MacTahoe-icon-theme.git)
