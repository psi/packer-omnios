echo '*       localhost:/export/home/&' >> /etc/auto_home

VAGRANT_PUB_KEY='https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

usermod -d /home/vagrant vagrant

mkdir -p /export/home/vagrant/.ssh
chmod 700 /export/home/vagrant/.ssh

curl $VAGRANT_PUB_KEY > /export/home/vagrant/.ssh/authorized_keys
chmod 600 /export/home/vagrant/.ssh/authorized_keys

chown -R vagrant /export/home/vagrant/.ssh

echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
