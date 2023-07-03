#!/usr/bin/env python3
####################################################
#      listen-for-shutdown.py                      #
#                                                  #
# For AtariPie                                     #
# Provides multi function capability               #
# froma single gpio button/led                     #
#                                                  #
# used in conjunction with multi_switch.sh from:   #
# https://github.com/crcerror                      #
#                                                  #
####################################################


# imports
from gpiozero import Button, LED
import os
from signal import pause
import subprocess
import time

# inits
global buttonMode
buttonMode=0
powerPin = 3
resetPin = 2
ledPin = 14
powerenPin = 4
hold_time = 2
led = LED(ledPin)
led.on()
power = LED(powerenPin)
power.on()


# set the buttonMode depending on how long the button is held for
def when_pressed():
    global buttonMode
    start_time=time.time()
    diff=0
    buttonMode=0

    while btn.is_active and (diff <hold_time) :
        now_time=time.time()
        diff=-start_time+now_time

    if diff < hold_time :
        buttonMode=1
    else:
        buttonMode=2

# determine what we should do depending on wether it's a short press or long pres
def when_released():
    global buttonMode
    if buttonMode == 1 :
#      print("the button had a short press - reset value")
       led.blink(on_time=0.25,off_time=0.25,n=2,background=False)
       print("executing restart task")
       output = int(subprocess.check_output(['/usr/local/bin/multi_switch.sh', '--es-pid']))
       output_rc = int(subprocess.check_output(['/usr/local/bin/multi_switch.sh', '--rc-pid']))
       if output_rc:
           os.system("/usr/local/bin/multi_switch.sh --closeemu")
       elif output:
           os.system("/usr/local/bin/multi_switch.sh --es-restart")
       else:
           os.system("sudo reboot")

    if buttonMode == 2 :
#       print("the button had a long press - poweroff value")
        led.blink(on_time=0.5,off_time=0.5,n=5,background=False)
        output = int(subprocess.check_output(['/usr/local/bin/multi_switch.sh', '--es-pid']))
        if output:
            os.system("/usr/local/bin/multi_switch.sh --es-poweroff")
        else:
            os.system("sudo shutdown -h now")
# reset state
    buttonMode=0
    led.on()
	


btn = Button(powerPin)
btn.when_pressed = when_pressed
btn.when_released = when_released
pause()
	