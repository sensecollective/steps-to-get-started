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

###########3
# extra
# LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin HOME=/home/arcolife USER=arcolife LOGNAME=arcolife QEMU_AUDIO_DRV=spice /usr/bin/qemu-kvm -name guest=boxes-unknown,debug-threads=on -S -object secret,id=masterKey0,format=raw,file=/home/arcolife/.config/libvirt/qemu/lib/domain-4-boxes-unknown/master-key.aes -machine pc-i440fx-2.6,accel=kvm,usb=off -cpu Haswell-noTSX -m 4104 -realtime mlock=off -smp 8,sockets=1,cores=4,threads=2 -uuid 66708f9f-5ad5-4fef-9921-2dd12fe912a0 -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/home/arcolife/.config/libvirt/qemu/lib/domain-4-boxes-unknown/monitor.sock,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 -boot strict=on -device ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x6.0x7 -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x6 -device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x6.0x1 -device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x6.0x2 -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5 -device usb-ccid,id=ccid0,bus=usb.0,port=2 -device usb-hub,id=hub0,bus=usb.0,port=1 -drive file=/home/arcolife/.local/share/gnome-boxes/images/boxes-unknown,format=qcow2,if=none,id=drive-ide0-0-0,cache=writeback -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1 -drive file=/home/arcolife/Downloads/Win10_1607_English_x64.iso,format=raw,if=none,id=drive-ide0-1-0,readonly=on -device ide-cd,bus=ide.1,unit=0,drive=drive-ide0-1-0,id=ide0-1-0 -netdev tap,fd=25,id=hostnet0 -device rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:0e:1f:34,bus=pci.0,addr=0x3 -chardev spicevmc,id=charsmartcard0,name=smartcard -device ccid-card-passthru,chardev=charsmartcard0,id=smartcard0,bus=ccid0.0 -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -chardev spicevmc,id=charchannel0,name=vdagent -device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=com.redhat.spice.0 -device usb-tablet,id=input0,bus=usb.0,port=3 -device usb-mouse,id=input1,bus=usb.0,port=4 -device usb-kbd,id=input2,bus=usb.0,port=5 -spice port=0,disable-ticketing,image-compression=off,seamless-migration=on -device qxl-vga,id=video0,ram_size=67108864,vram_size=67108864,vram64_size_mb=0,vgamem_mb=16,max_outputs=1,bus=pci.0,addr=0x2 -device intel-hda,id=sound0,bus=pci.0,addr=0x4 -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 -chardev spicevmc,id=charredir0,name=usbredir -device usb-redir,chardev=charredir0,id=redir0,bus=usb.0,port=6 -chardev spicevmc,id=charredir1,name=usbredir -device usb-redir,chardev=charredir1,id=redir1,bus=usb.0,port=1.1 -chardev spicevmc,id=charredir2,name=usbredir -device usb-redir,chardev=charredir2,id=redir2,bus=usb.0,port=1.2 -chardev spicevmc,id=charredir3,name=usbredir -device usb-redir,chardev=charredir3,id=redir3,bus=usb.0,port=1.3 -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x7 -msg timestamp=on
