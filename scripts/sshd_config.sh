sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

cat <<EOF >> /etc/ssh/sshd_config

LookupClientHostnames no
EOF
