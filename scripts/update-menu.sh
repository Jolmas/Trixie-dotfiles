#!/bin/sh
#
# This is an example wrapper script for `labwc-menu-generator` which aims to
# demonstrate how a user can customize the menu with entries before/after the
# directories and to ignore certain applications.
#
# `labwc-menu-generator` does the hard work of parsing system application
# .desktop files and categorizing them into directories. Technically it would
# of course be possible to add options for further customisation such as what
# is achieved by this script, but that would mostly likely result in a couple
# of undesireable outcomes:
#
# 1. Significantly extend project scope to cater for unusual and obscure
#    requirements (including translations), thus making it harder to maintain
#    and less likely to survive in the long-run.
#
# 2. Make the user-interface disproportionately more complicated compared with
#    writing a simple wrapper script.
#

ignore_files=$(mktemp)
trap "rm -f $ignore_files" EXIT
cat <<'EOF' >${ignore_files}
cups.desktop
lstopo.desktop
urxvtc.desktop
urxvt-tabbed.desktop
xterm.desktop
rofi.desktop
rofi-theme-selector.desktop
org.kde.kcachegrind.desktop
org.kde.massif-visualizer.desktop
org.kde.kuserfeedback-console.desktop
org.kde.accessibilityinspector.desktop
org.kde.heaptrack.desktop
calf.desktop
org.kde.plasma-welcome.desktop
kde_wacom_tabletfinder.desktop
konqbrowser.desktop
EOF

printf '%b\n' '<?xml version="1.0" encoding="UTF-8"?>
<openbox_menu>
<menu id="root-menu" label="root-menu">
    <item label="Terminal" icon="konsole">
      <action name="Execute"><command>foot</command></action>
    </item>
	<item label="Archivos" icon="org.kde.dolphin">
      <action name="Execute"><command>thunar</command></action>
    </item>
  <separator />'

# -b|--bare    Disables header and footer
# -i|--ignore  Excludes all .desktop files listed at the top of this file
/usr/local/bin/labwc-menu-generator -I -b -i "${ignore_files}" -t 'foot'

printf '%b\n' '<separator />
   <menu id="40" label="LabWC" icon="labwc-tweaks-gtk">
            <menu id="client-list-menu"/>
            	<item label="Actualizar Menú" icon="menulibre">
              		<action name="Execute"><command>~/.config/scripts/update-lwmenu.sh</command>
              		</action>
            	</item>
	    		<item label="Cambiar Wallpaper" icon="preferences-desktop-wallpaper">
              		<action name="Execute"><command>~/.config/scripts/WpSel.sh</command>
              		</action>
	    		</item>
            	<item label="Estilo de Waybar" icon="dock">
              		<action name="Execute"><command>~/.config/scripts/WayStyle.sh</command>
              		</action>
            	</item>
				<item label="Temas LabWC" icon="preferences-desktop-color">
    	  			<action name="Execute"><command>~/.config/scripts/LabwcTheme.sh</command></action>
    			</item>
	    		<item label="Tweaks" icon="labwc-tweaks-gtk">
    	  			<action name="Execute"><command>labwc-tweaks-gtk</command></action>
    			</item>
            	<item label="Ajustes Avanzados" icon="gedit">
              		<action name="Execute"><command>~/.config/scripts/WofiEdit.sh</command>
              		</action>
            	</item>
				<item label="Aplicar Ajustes" icon="grsync"> 
    	  			<action name="Execute"><command>~/.config/scripts/reload.sh</command></action>
            	</item>
     	</menu>
            <item label="Salir" icon="session-properties">
              <action name="Execute"><command>wlogout</command>
              </action>
            </item>
</menu> <!-- root-menu -->
</openbox_menu>'
