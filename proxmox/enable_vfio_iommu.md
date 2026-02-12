**Step 1.**  
```
nano /etc/default/grub
```  
dodanie intel_iommu=on iommu=pt  
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"  
```
**Step 2.**  
```
sudo update-grub
```  
**Step 3.**  
```
sudo nano /etc/modules
```  
vfio  
vfio_iommu_type1  
vfio_pci  
vfio_virqfd  
