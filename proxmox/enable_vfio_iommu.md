nano /etc/default/grub - dodanie intel_iommu=on iommu=pt
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"

sudo update-grub

7.sudo nano /etc/modules
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
