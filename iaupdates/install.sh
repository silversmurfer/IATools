#!/bin/bash
# InstArcade update script

#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

#Step X) Clean UP----------------------------------
#-----------------------------------------------------------
cd /tmp
rm -rf /tmp/IATools
#-----------------------------------------------------------

#Step 2) Clone update repo----------------------------------
#-----------------------------------------------------------
cd /tmp
git clone https://github.com/silversmurfer/IATools.git
#-----------------------------------------------------------


#Step 3) Update motd----------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Updating banner"
cp -f /tmp/IATools/iaupdates/motd /etc
#-----------------------------------------------------------

#Step 4) Fix Bluray theme----------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Fixing Bluray theme to be family friendly"
cp -f /tmp/IATools/iaupdates/themes/bluray/auto-allgames/_inc/system.png /etc/emulationstation/themes/bluray/auto-allgames/_inc/
#-----------------------------------------------------------

#Step 5) Fix folder permissions on config files----------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Fixing folder permissions on configs"
chown -R pi:pi /opt/retropie/configs/*
#-----------------------------------------------------------

#Step 6) Fix retroarch config files----------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Updating retroarch config files"
cp -f /tmp/IATools/iaupdates/configs/all/retronetplay.cfg /opt/retropie/configs/all/
#-----------------------------------------------------------

#Step 7) Fix emulationstation collections----------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Updating emulationstaion collections"
cp -rf /tmp/IATools/iaupdates/configs/all/emulationstation/collections /opt/retropie/configs/all/emulationstation/
#-----------------------------------------------------------

#Step X) Clean UP----------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Cleaning up after"
rm -rf /tmp/IATools
#-----------------------------------------------------------