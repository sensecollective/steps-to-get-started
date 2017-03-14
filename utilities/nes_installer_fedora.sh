sudo dnf install -y mesa-dri-drivers mesa-libGL xorg-x11-drv-ati
sudo dnf install -y mesa-libGL-devel
sudo dnf install libXrandr libXrandr-devel libXcursor-devel libXinerama-devel libXi-devel

# install go and then do this:
go get github.com/fogleman/nes
