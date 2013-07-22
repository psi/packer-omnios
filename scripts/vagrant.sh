# Turn on auto_home
echo '*       localhost:/export/home/&' >> /etc/auto_home

# Fix vagrant's homedir
usermod -d /home/vagrant vagrant

# Install vagrant's SSH pubkey
VAGRANT_PUB_KEY='https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

mkdir -p /export/home/vagrant/.ssh
chmod 700 /export/home/vagrant/.ssh
curl $VAGRANT_PUB_KEY > /export/home/vagrant/.ssh/authorized_keys
chmod 600 /export/home/vagrant/.ssh/authorized_keys
chown -R vagrant /export/home/vagrant/.ssh

# Allow vagrant passwordless sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
