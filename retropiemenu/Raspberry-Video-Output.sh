#!/bin/bash

infobox=""
infobox="${infobox}\n
infobox="${infobox}===============================================================================================================\n\n""                                                     
infobox="${infobox}\n"  
infobox="${infobox}          #### ##    ##  ######  ######## ########  ##     ##  ######  ######## ####  #######  ##    ##  ######\n"  
infobox="${infobox}           ##  ###   ## ##    ##    ##    ##     ## ##     ## ##    ##    ##     ##  ##     ## ###   ## ##    ##\n" 
infobox="${infobox}           ##  ####  ## ##          ##    ##     ## ##     ## ##          ##     ##  ##     ## ####  ## ##\n"       
infobox="${infobox}           ##  ## ## ##  ######     ##    ########  ##     ## ##          ##     ##  ##     ## ## ## ##  ######\n"  
infobox="${infobox}           ##  ##  ####       ##    ##    ##   ##   ##     ## ##          ##     ##  ##     ## ##  ####       ##\n" 
infobox="${infobox}           ##  ##   ### ##    ##    ##    ##    ##  ##     ## ##    ##    ##     ##  ##     ## ##   ### ##    ##\n" 
infobox="${infobox}          #### ##    ##  ######     ##    ##     ##  #######   ######     ##    ####  #######  ##    ##  ######\n\n"                                                   
infobox="${infobox}\n"
infobox="${infobox}             This script will edit your config.txt file to allow for simple change of the screen Resolution.\n"
infobox="${infobox}                     If you change to a setting that is incompatable with your system and no longer\n"
infobox="${infobox}               can see your build.  Simply run this script via SSH and select Re-Enable Auto Detection.\n"
infobox="${infobox}===============================================================================================================\n\n"                                      
infobox="${infobox}\n"

dialog --backtitle "Screen Resolution by the Supreme Team" \
--title "Screen Resolution Changer" \
--msgbox "${infobox}" 55 120

# Config file path
CONFIG_PATH=/boot/config.txt

# description
SCREEN_DESCRIPTION="#uncomment to enable screen resolution settings"

declare -a SCREEN_SETTINGS=(
  "hdmi_drive=2"
  "hdmi_group=1"
  "#hdmi_mode=1"
)

function main_menu() {
    local choice
    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "Choose your Screen settings:" 25 75 20 \
            - "*** Monitor/TV SELECTIONS ***" \
            1 "Force 320x240   (crt 4:3)" \
    	    2 "Force 320x240   (crt 16:9)" \
			3 "Force 1280x960  (crt 5:4)" \
	        4 "Force 640x480   (vga 4:3)" \
            5 "Force 640x480   (vga 16:9)" \
			6 "Force 1280x1024 (vga 5:4)" \
	        7 "Force 1200x720  (720P)" \
            8 "Force 1920x1080 (1080P)" \
            9 "re-enable autodetection" \
            2>&1 > /dev/tty)
        case "$choice" in
            1) enable_screenres 8;;
	        2) enable_screenres 9;;
	        3) enable_screenres 34;;
            4) enable_screenres 2;;
			5) enable_screenres 3;;
			6) enable_screenres 35;;
            7) enable_screenres 4;;
            8) enable_screenres 16;;
            9) disable_screenres ;;
            *) break ;;
        esac
    done
}

function enable_screenres() {
  dialog --infobox "...Applying..." 3 20 ; sleep 2
#  
  sudo sed -i "s|#*hdmi_mode=.*|hdmi_mode=$1|" "${CONFIG_PATH}";
  for val in ${SCREEN_SETTINGS[@]}; do
    if grep -q "#${val}" ${CONFIG_PATH}; then
      sudo sed -i "s|#${val}|${val}|" "${CONFIG_PATH}";
    fi
  done
  echo
read -n 1 -s -r -p "Press any key to reboot"
  echo "[OK] Rebooting Raspberry Pi ... "
  sudo reboot
}

# 
function disable_screenres() {
  dialog --infobox "...Applying..." 3 20 ; sleep 2
#  
  sudo sed -i "s|hdmi_mode=|#hdmi_mode=|" "${CONFIG_PATH}";
  for val in ${SCREEN_SETTINGS[@]}; do
    sudo sed -i "s|^${val}|#${val}|" "${CONFIG_PATH}";
  done
  echo
read -n 1 -s -r -p "Press any key to reboot"
  echo "[OK] Rebooting Raspberry Pi ... "
  sudo reboot
}

# 
function screen_setup() {
  if ! grep -q "${SCREEN_DESCRIPTION}" ${CONFIG_PATH}; then
    sudo echo -e "\n${SCREEN_DESCRIPTION}" >> ${CONFIG_PATH}
    for val in ${SCREEN_SETTINGS[@]}; do
      if ! grep -q "${val}" ${CONFIG_PATH}; then
        sudo echo $val >> ${CONFIG_PATH}
      fi
    done
  fi
}




main_menu
