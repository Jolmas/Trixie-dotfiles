#!/bin/bash

# DankMaterialShell Minimize Patch
# Este script aplica los cambios necesarios para que las apps se minimicen al clickear sus iconos.

DMS_PATH="$HOME/.config/quickshell/dms"

echo "Aplicando parche de minimizado a DankMaterialShell..."

# 1. Modificar CompositorService.qml para agregar toggleMinimize
python3 <<EOF
import os

filepath = "$DMS_PATH/Services/CompositorService.qml"
if not os.path.exists(filepath):
    print(f"Error: {filepath} no encontrado.")
    exit(1)

with open(filepath, 'r') as f:
    content = f.read()

if "function toggleMinimize" in content:
    print("CompositorService.qml ya tiene toggleMinimize.")
else:
    insertion = """
    function toggleMinimize(toplevel) {
        if (!toplevel)
            return;

        if (isLabwc) {
            if (toplevel.activated) {
                Quickshell.execDetached(["wlrctl", "window", "minimize"]);
            } else {
                toplevel.activate();
            }
            return;
        }

        if (isHyprland) {
            const hyprToplevel = Array.from(Hyprland.toplevels.values).find(t => t.wayland === toplevel);
            if (hyprToplevel) {
                const wsName = String(hyprToplevel.lastIpcObject?.workspace?.name || hyprToplevel.workspace?.name || "");
                if (wsName.startsWith("special:minimized")) {
                    Hyprland.dispatch("togglespecialworkspace minimized");
                    Qt.callLater(() => toplevel.activate());
                } else if (toplevel.activated) {
                    Hyprland.dispatch("movetoworkspacesilent special:minimized");
                } else {
                    toplevel.activate();
                }
            } else {
                toplevel.activate();
            }
            return;
        }

        if (isNiri) {
            if (toplevel.activated) {
                Quickshell.execDetached(["niri", "msg", "action", "minimize-window"]);
            } else {
                toplevel.activate();
            }
            return;
        }

        toplevel.activate();
    }
"""
    # Insert before the last closing brace
    last_brace = content.rfind('}')
    new_content = content[:last_brace] + insertion + content[last_brace:]
    with open(filepath, 'w') as f:
        f.write(new_content)
    print("CompositorService.qml actualizado.")
EOF

# 2. Modificar DockAppButton.qml
python3 <<EOF
import os

filepath = "$DMS_PATH/Modules/Dock/DockAppButton.qml"
if os.path.exists(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content.replace("windowToplevel.activate();", "CompositorService.toggleMinimize(windowToplevel);")
    new_content = new_content.replace("groupedToplevel.activate();", "CompositorService.toggleMinimize(groupedToplevel);")
    
    with open(filepath, 'w') as f:
        f.write(new_content)
    print("DockAppButton.qml actualizado.")
EOF

# 3. Modificar RunningApps.qml
python3 <<EOF
import os

filepath = "$DMS_PATH/Modules/DankBar/Widgets/RunningApps.qml"
if os.path.exists(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    old_cycle = """                                    const nextIndex = (currentIndex + 1) % groupData.windows.length;
                                    groupData.windows[nextIndex].toplevel.activate();"""
    new_cycle = """                                    const nextIndex = (currentIndex + 1) % groupData.windows.length;
                                    const nextToplevel = groupData.windows[nextIndex].toplevel;
                                    if (nextToplevel.activated) {
                                        CompositorService.toggleMinimize(nextToplevel);
                                    } else {
                                        nextToplevel.activate();
                                    }"""
    
    new_content = content.replace(old_cycle, new_cycle)
    new_content = new_content.replace("toplevelObject.activate();", "CompositorService.toggleMinimize(toplevelObject);")
    
    with open(filepath, 'w') as f:
        f.write(new_content)
    print("RunningApps.qml actualizado.")
EOF

# 4. Modificar AppsDock.qml
python3 <<EOF
import os

filepath = "$DMS_PATH/Modules/DankBar/Widgets/AppsDock.qml"
if os.path.exists(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content.replace("modelData.allWindows[0].toplevel.activate();", "CompositorService.toggleMinimize(modelData.allWindows[0].toplevel);")
    
    old_cycle = """                                const nextIndex = (currentIndex + 1) % modelData.allWindows.length;
                                modelData.allWindows[nextIndex].toplevel.activate();"""
    new_cycle = """                                const nextIndex = (currentIndex + 1) % modelData.allWindows.length;
                                const nextToplevel = modelData.allWindows[nextIndex].toplevel;
                                if (nextToplevel.activated) {
                                    CompositorService.toggleMinimize(nextToplevel);
                                } else {
                                    nextToplevel.activate();
                                }"""
    
    new_content = new_content.replace(old_cycle, new_cycle)
    
    with open(filepath, 'w') as f:
        f.write(new_content)
    print("AppsDock.qml actualizado.")
EOF

echo "Parche aplicado exitosamente. Reinicia DankMaterialShell para ver los cambios."
