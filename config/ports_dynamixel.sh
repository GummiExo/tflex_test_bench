#!/bin/bash

echo Configuring ports to minimum latency timer
sudo chmod 777 -R /sys/bus/usb-serial/devices/ttyUSB0/latency_timer 
sudo chmod 777 -R /sys/bus/usb-serial/devices/ttyUSB1/latency_timer
#sudo chmod 777 -R /sys/bus/usb-serial/devices/ttyUSB2/latency_timer 
echo 1 > /sys/bus/usb-serial/devices/ttyUSB0/latency_timer
echo 1 > /sys/bus/usb-serial/devices/ttyUSB1/latency_timer
#echo 1 > /sys/bus/usb-serial/devices/ttyUSB2/latency_timer
