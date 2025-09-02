#!/bin/bash
reload() {
labwc -r | notify-send "Changes Done!!"
}
reload
