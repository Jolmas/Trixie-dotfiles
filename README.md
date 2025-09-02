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

- Scripts used by Waybar

`GrimShot.sh` = Screenshot (require: grim, slurp, swaymsg, wl-copy, jq and notify-send)

`LabwcTheme.sh`= Theme Changer

`LockScreen.sh` = Screen locker

`Volume.sh` = Volume manager

Trick for Workspaces on Waybar

```
WSpaces.sh 
wsactive.sh
wsactive1.sh
wsactive2.sh
wsactive3.sh
wsactive4.sh
wstmp.sh
```

`xupdate` Search and apply updates (require: nala)

- Scripts used by LabWC

`Waybar.sh` = Start waybar

`Labcmd.sh` = Show LabWC active command keybinds

`WpSel.sh` = Change Wallpaper (require: ImageMagick, create directory ~/Pictures/Wallpapers and copy your images inside)

`ScreenShot.sh` = Screenshooter

`wofi-light.sh` = Launch wofi
 
`ShowDesk.sh` = Minimize all windows (require: wlrctl)

`update-lwmenu.sh` = Launch update-menu.sh saving to ~/config/labwc/menu.xml 

`update-menu.sh` = Update menu with presets (require: labwc-menu-generator)

`WayStyle.sh` = Change waybar style

`WofiEdit.sh` = Launch advanced settings
 
`reload.sh` = Reload labwc configuration

`temagtk.sh` = Load gtk theme settings at startup

`temaico.sh` = Load icons settings at startup

`getnf` = Install Nerd Fonts needed for Wayland icons (Hack - JetBrainsMono)

## Required Packages

- `labwc`
- `dunst`
- `swaylock`
- `swaybg`
- `rofi`
- `waybar`
- `wlogout`
- `wofi`
- `copyq`
- `wlsunset`
- `foot`
- `micro`
- `wtype`
-  Download and install the Themes LabWC `git clone https://github.com/Jolmas/LabWC.git`
