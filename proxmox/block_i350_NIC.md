sudo nano /etc/modprobe.d/vfio.conf
options vfio-pci ids=8086:1521

sudo nano /etc/modprobe.d/blacklist-igb.conf
blacklist igb

sudo update-initramfs -update
