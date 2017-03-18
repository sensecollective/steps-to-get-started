#!/bin/bash

# credit: https://ask.fedoraproject.org/en/question/65034/gnome-boxes-usb-forwarding-not-working/

# For redirection to work, the virtual machine must have an USB2 EHCI controller
# (this implies 3 additional UHCI controllers). It also needs to have Spice channels
# for USB redirection. The number of such channels correspond to the number of USB
# devices that it will be possible to redirect at the same time.

# Using QEMU we need to add EHCI/UHCI controllers to QEMU command line,
# and we also need to add one Spice redirection channel per device we want
# to redirect simultaneously.

################################################################################
# detect iPhone 5S
lsusb -d 05ac:12a8

################################################################################
# use these steps first, and see if there's a process holding the usb dev busy
lsof | grep dev/bus/usb
systemctl stop usbmuxd

################################################################################
# then, if enabling USB redirection from VMM / Boxes still doesn't work,
# run that VM as follows:
pkexec --user root qemu-system-x86_64 \
       -machine accel=kvm \
       -smp 2 -m 4096 \
       -net none \
       -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
       -device usb-host,hostbus=3,hostaddr=6 \
       -usb /home/arcolife/.local/share/gnome-boxes/images/boxes-unknown \
       -boot c -vnc 127.0.0.1:1

################################################################################
# After you stated this connection, you can access the VM over Remote Desktop.
# Open the programm, click on Connect and select Protocol VNC and Host localhost:5901.
# After this click connect. Hopefully it will work for you.
