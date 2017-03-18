#!/bin/bash

# To use iTunes, I had to install it in a Win 10 VM in VMM / Boxes.
# There are hacks I had to perform to get all funcs to working
# (ref: `steps-to-get-started/utilities/iphone_usb_redir_qemu.sh`).
# When I solved usb redir issue with VMM and tried to upgrade iOS,
# it pegged my Linux host's CPU (100% reproducible); I solved that by
# re-enabling usbmuxd (which multiplexes connections to Apple devices).
# I had to disable this because I wasn't able to perform USB redirection
# since usbmuxd was keeping the device resource busy. I don't know why next 
# time onwards, I had to never disable it again, but.. whatever works atm. 
# Also, when the 5S was stuck earlier in restoration mode, I tried out 
# tinyumbrella64.exe too (had to install JRE in win 10 VM for that), but 
# the software never really started (neither gave out an error). 
# So there's that.

# In another incident, my VM disks dried up because I had enabled iCloud photo sync
# on the VM while not allocating enough storage space. I could just expand the storage,
# but rather wanted to share data between Win 10 VM and Linux host. So I read some forums
# and decided to stick with Samba sharing. Here's how I backed up my iCloud Photos 
# to Linux host: `steps-to-get-started/tutorials/samba` (icloud has disabled downloading 
# multiple photos from their web browser endpoint, and there's no linux client.
# So I had to follow this route)

# UPDATE: so when this itunes hack + iOS upgrade finally worked after restarting usbmuxd,
# the white/grey progress bar below apple logo (in upgrade/restoration mode) lit up halfway
# and then the phone restarted. I'm guessing, it copied the extracted 10.2.1 update onto 
# that phone and then restarted the phone. (this disconnected usb connection to my VM; 
# FYI I had to regularly monitor/perform the USB Redirection due to these restarts during the upgrade). 
# I could've just upgraded from WiFi + iPhone downloads, but then again, I had a strong urge
# to explore the alternatives. Also, I upgraded 2vcpu VM to 4vcpus just in case.
# (and these cores were infact utilized during download / backup process of iTunes). 

# UPDATE2: Finally, the upgrade worked without restoring. I'll now explore 

# credit: https://ask.fedoraproject.org/en/question/65034/gnome-boxes-usb-forwarding-not-working/

# Quoting above link:
# # For redirection to work, the virtual machine must have an USB2 EHCI controller
# # (this implies 3 additional UHCI controllers). It also needs to have Spice channels
# # for USB redirection. The number of such channels correspond to the number of USB
# # devices that it will be possible to redirect at the same time.

# # Using QEMU we need to add EHCI/UHCI controllers to QEMU command line,
# # and we also need to add one Spice redirection channel per device we want
# # to redirect simultaneously.

# Also, just in case:
# - http://www.tenorshare.com/iphone-data/how-to-fix-frozen-iphone-during-ios-8-update.html#Trick2
# - https://www.enigma-recovery.com/fix-iphone-stuck-recovery-mode/
# - http://unix.stackexchange.com/questions/86071/use-virt-manager-to-share-files-between-linux-host-and-windows-guest

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
