# Mount the tools ISO
lofiadm -a /root/solaris.iso /dev/lofi/1
mount -F hsfs -o ro /dev/lofi/1 /mnt

# Extract the installer
cd /tmp
tar xpzf /mnt/vmware-solaris-tools.tar.gz

# The installer needs access to /mnt, so free it up
umount /mnt
lofiadm -d /dev/lofi/1

# Install
cd vmware-tools-distrib
./vmware-install.pl --default

# Clean up our mess
cd /
rm -rf /tmp/vmware-tools-distrib /root/solaris.iso
