#!/bin/bash
reload() {
labwc -r | notify-send "Se aplicaron los cambios !!"
}
reload
