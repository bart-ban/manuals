**sftpserver**  

**Step 1. grupa sftpgroup**  
```
groupadd sftpgroup
```
**Step 2.**  
```
useradd -G sftpgroup -d /srv/bart -s /sbin/nologin bart
```
**Step 3.**  
```
passwd bart
```
**Step 4.**
```
mkdir -p /srv/bart
```
**Step 5.**  
```
chown root /srv/bart
```
**Step 6.**  
```
chmod g+rx /srv/bart
```
**Step 7.**  
```
mkdir -p /srv/bart/data
```
**Step 8.**  
```
chown bart:bart /srv/bart/data
```
**Step 9. **
```
nano /etc/ssh/sshd_config
```
**Step 10.**  
```
dodac # przed Subsystem	sftp	/usr/lib/openssh/sftp-server
```
**Step 11.**  
wpisac ponizsze  
```Subsystem	sftp	internal-sftp
Match Group sftpgroup
	ChrootDirectory %h
	X11Forwarding no
	AllowTCPForwarding no
	ForceCommand internal-sftp
```
