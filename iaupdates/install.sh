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
# wget -N -q --show-progress "https://raw.githubusercontent.com/silversmurfer/IATools/master/iaupdates/motd"

#-----------------------------------------------------------