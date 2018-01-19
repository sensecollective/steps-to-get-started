# Example

### share windows folder on linux 

Step 1: (setup win a/c w/ password)

- set windows password for default user.
  Press ctrl+alt+del and select change password.
  
- Or, press windows key + R, and type `control userpasswords2`.
  And add a new user with password.

Step 2: follow [this blog to setup shared folder on windows 10](https://www.howtogeek.com/176471/how-to-share-files-between-windows-and-linux/)

Step 3: ensure you have cifs-utils installed on linux

Step 4:
```
$ mkdir ~/Desktop/Windows-Share/

$ sudo mount.cifs //192.168.122.138/Share /home/arcolife/Desktop/Windows-Share/ -o user=arco
$ # enter password for windows user a/c when prompted

```

Step 5: unmount, when done. (run with sudo)

###### NoteToSelf
I was unable to unmount this, even after forcing the VM to stop. The whole thing got stuck and I tried to `pkill/kill -9` the cifsd/cifsiod processes in vain. I stopped smb.service although that wasn't required and was unrelated. `df -hT / df -k -F cifs` were stuck for a while. I discovered later that it was a CIFS timeout and had to be worked around using [this hack](http://serverfault.com/questions/622238/linux-cifs-samba-mount-hangs-for-several-minutes) - `sudo umount -a -t cifs -l`

```
mount -v  | grep cifs
df -k -F cifs

sudo umount /home/arcolife/Desktop/Windows-Share

OR 

sudo umount -a -t cifs -l
```

### share linux folder on windows

There are many other ways to share, but we're going with samba for now..

Step 1: Samba setup

Add this to your samba conf:

```
# optional
# guest account = nobody
# guest ok = yes
# RTFM for this (I'm not sure about these settings)

[LinuxHost]
        comment = Host Share
        path = /home/arcolife/workspace/vm_storage
        valid users = arcolife
        public = no
        writable = yes
        printable = no
```

Close the file, and run `testparm` to ensure all good with conf.

Step 2: WIP
