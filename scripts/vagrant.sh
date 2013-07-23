# Fix vagrant's homedir
usermod -d /home/vagrant vagrant

# Install vagrant's SSH pubkey
mkdir -p /export/home/vagrant/.ssh
chmod 700 /export/home/vagrant/.ssh
curl https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub > /export/home/vagrant/.ssh/authorized_keys
chmod 600 /export/home/vagrant/.ssh/authorized_keys
chown -R vagrant /export/home/vagrant/.ssh

# Allow vagrant passwordless sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
