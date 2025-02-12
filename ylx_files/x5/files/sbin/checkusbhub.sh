#!/bin/sh

check_usbhub(){
    if ! lsusb|grep -q '05e3:';then
        if [ "`fw_printenv hver|cut -d"=" -f2`"x = "v3"x ];then
            [ ! -d /sys/class/gpio/gpio454 ] && {
            echo 454 > /sys/class/gpio/export
            echo out > /sys/class/gpio/gpio454/direction
            }
            echo 0 > /sys/class/gpio/gpio454/value
            sleep 7
            echo 1 > /sys/class/gpio/gpio454/value
        else
            # echo "not v3 board"
            echo 0 > /sys/class/leds/modem/brightness
            sleep 10
            echo 1 > /sys/class/leds/modem/brightness
        fi

        sleep 10
    fi
}

while ! lsusb |grep 05e3:0620
do
    check_usbhub
done
