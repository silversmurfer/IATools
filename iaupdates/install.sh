#!/bin/bash


#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------


#-----------------------------------------------------------

#Step 2) Update motd----------------------------------
#-----------------------------------------------------------
cd /tmp
wget -N -q --show-progress "https://raw.githubusercontent.com/silversmurfer/IATools/master/iaupdates/motd"
mv -f /tmp/motd /etc

#-----------------------------------------------------------

#Step 3) Fix Bluray theme----------------------------------
#-----------------------------------------------------------
cd /tmp
wget -N -q --show-progress "https://raw.githubusercontent.com/silversmurfer/IATools/master/iaupdates/themes/bluray/auto-allgames/_inc/system.png"
mv -f /tmp/system.png /etc/emulationstation/themes/bluray/auto-allgames/_inc/

#-----------------------------------------------------------

