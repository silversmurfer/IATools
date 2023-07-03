#!/bin/bash

infobox= ""
infobox="${infobox}_______________________________________________________________________\n\n"
infobox="${infobox}\n"
infobox="${infobox}RetroPie Emulation Station Bootup Theme Randomizer\n\n"
infobox="${infobox}This script, when enabled, will randomly choose an installed Emulation Station theme to use on bootup.\n"
infobox="${infobox}\n"
infobox="${infobox}It will automatically pick any of the installed themes that are available and use that new theme when Emulation Station starts.\n"
infobox="${infobox}\n"
infobox="${infobox}Note: not all themes support the same systems and collections.\n"

dialog --backtitle "RetroPie Emulation Station Bootup Theme Randomizer" \
--title "RetroPie Emulation Station Bootup Theme Randomizer" \
--msgbox "${infobox}" 20 80

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Enable Theme Randomizer" \
            2 "Disable Theme Randomizer" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) enable_script  ;;
            2) disable_script  ;;
            *)  break ;;
        esac
    done
}

function disable_script() {
dialog --infobox "...processing..." 3 20 ; sleep 2
perl -pi -w -e 's/\/home\/pi\/scripts\/themerandom.sh/#\/home\/pi\/scripts\/themerandom.sh/g;' /opt/retropie/configs/all/autostart.sh
sleep 2
}

function enable_script() {
dialog --infobox "...processing..." 3 20 ; sleep 2
perl -pi -w -e 's/#\/home\/pi\/scripts\/themerandom.sh/\/home\/pi\/scripts\/themerandom.sh/g;' /opt/retropie/configs/all/autostart.sh
sleep 2
}

main_menu

