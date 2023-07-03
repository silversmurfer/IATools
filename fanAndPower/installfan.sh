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


#Step 3) Create fan Service ----------------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Creating Fan Service"
cp /tmp/IATools/fanAndPower/run-fan.service /lib/systemd/system/
cp /tmp/IATools/fanAndPower/run-fan.py /usr/local/bin/
systemctl daemon-reload
systemctl enable run-fan.service
#-----------------------------------------------------------

#Step 4) Create Power Service ----------------------------------------
#-----------------------------------------------------------
cd /tmp
echo "Creating Power LED Service"
cp /tmp/IATools/fanAndPower/listen-for-shutdown.service /lib/systemd/system/
cp /tmp/IATools/fanAndPower/listen-for-shutdown.py /usr/local/bin/
cp /tmp/IATools/fanAndPower/multi_switch.sh /usr/local/bin/
chmod +x /usr/local/bin/multi_switch.sh
systemctl daemon-reload
systemctl enable listen-for-shutdown.service
#-----------------------------------------------------------



#Step X) Clean UP-------------------------------------------
#-----------------------------------------------------------
# cd /tmp
# echo "Cleaning up after"
# rm -rf /tmp/IATools
#-----------------------------------------------------------