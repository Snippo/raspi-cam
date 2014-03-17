#!/bin/sh
# http://root42.blogspot.nl/2013/03/how-to-make-raspberry-pi-automatically.html
TESTIP=192.168.2.254

ping -c4 ${TESTIP} > /dev/null

if [ $? != 0 ]
then
    logger -t $0 "WiFi seems down, restarting"
    sudo ifdown --force wlan0
    sudo ifup wlan0
else
    logger -t $0 "WiFi seems up."
fi