#!/bin/bash
# InstArcade fan and power setup script

#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi
#-----------------------------------------------------------

#Step X) Clean UP-------------------------------------------
#-----------------------------------------------------------
echo "Cleaning up before"
cd /tmp
rm -rf /tmp/IATools
#-----------------------------------------------------------

#Step 2) Clone update repo----------------------------------
#-----------------------------------------------------------
cd /tmp
git clone https://github.com/silversmurfer/IATools.git
#-----------------------------------------------------------


#Step 3) Create Service ----------------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Updating banner"
cp /tmp/IATools/fanAndPower/run-fan.service /lib/systemd/system/
cp /tmp/IATools/fanAndPower/run-fan.py /usr/local/bin/
systemctl daemon-reload
systemctl enable run-fan.service
# cp -f /tmp/IATools/iaupdates/motd /etc
#-----------------------------------------------------------



#Step X) Clean UP-------------------------------------------
#-----------------------------------------------------------
# cd /tmp
# echo "Cleaning up after"
# rm -rf /tmp/IATools
#-----------------------------------------------------------