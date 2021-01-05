#!/bin/bash

read -p "Unplug all devices and press enter"
ls -1d /dev/* > /tmp/.mining_device_find1.txt

read -p "Plug in all mining devices and press enter"
ls -1d /dev/* > /tmp/.mining_device_find2.txt

echo "USB devices:"
diff -u /tmp/.mining_device_find1.txt /tmp/.mining_device_find2.txt | sed -n '/^+[^+]/ s/^+//p'

rm /tmp/.mining_device_find1.txt /tmp/.mining_device_find2.txt
