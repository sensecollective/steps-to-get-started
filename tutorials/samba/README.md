# Example

### share windows folder on linux 

Step 1: (setup win a/c w/ password)

- set windows password for default user.
  Press ctrl+alt+del and select change password.
  
- Or, press windows key + R, and type `control userpasswords2`.
  And add a new user with password.

Step 2: follow [this blog to setup shared folder on windows 10](https://www.howtogeek.com/176471/how-to-share-files-between-windows-and-linux/)

Step 3: ensure you have cifs-utils and samba installed on linux


```
$ mkdir ~/Desktop/Windows-Share/

$ sudo mount.cifs //192.168.122.138/Share /home/arcolife/Desktop/Windows-Share/ -o user=arco
$ # enter password for windows user a/c when prompted

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
