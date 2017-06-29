#!/bin/bash -e
mv files/*.jar   			${ROOTFS_DIR}/home/pi/
mv files/plclogo.cfg   			${ROOTFS_DIR}/home/pi/
install -m 644 files/regenerate_ssh_host_keys.service	${ROOTFS_DIR}/lib/systemd/system/
install -m 755 files/apply_noobs_os_config		${ROOTFS_DIR}/etc/init.d/
install -m 755 files/resize2fs_once			${ROOTFS_DIR}/etc/init.d/
install -d						${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d
install -m 644 files/ttyoutput.conf			${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d/
install -m 644 files/50raspi				${ROOTFS_DIR}/etc/apt/apt.conf.d/
install -m 644 files/console-setup   			${ROOTFS_DIR}/etc/default/


on_chroot << EOF
systemctl disable hwclock.sh
systemctl disable nfs-common
systemctl disable rpcbind
systemctl disable ssh
systemctl enable regenerate_ssh_host_keys
systemctl enable apply_noobs_os_config
systemctl enable resize2fs_once
EOF

on_chroot << \EOF
for GRP in input spi i2c gpio; do
	groupadd -f -r $GRP
done
for GRP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev; do
  adduser pi $GRP
done
EOF

on_chroot << EOF
setupcon --force --save-only -v
EOF

on_chroot << EOF
usermod --pass='*' root
sudo chown -R pi:pi /home/pi
yes | sudo apt-get update
yes | sudo apt-get upgrade
yes | sudo apt-get install oracle-java8-jdk
yes | sudo apt-get install screen mc vim git htop
yes | sudo apt-get install sshpass
yes | wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -
yes | sudo apt-get install apt-transport-https
yes | echo 'deb https://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list
yes | sudo apt-get update
yes | sudo apt-get install openhab2
yes | sudo systemctl daemon-reload
yes | sudo systemctl enable openhab2.service
sshpass -p habopen ssh -p8101 openhab@localhost < feature:install openhab-runtime-compat1x
sudo mv /home/pi/*.jar /usr/share/openhab2/addons
sudo mv /home/pi/plclogo.cfg /etc/openhab2/services
EOF

rm -f ${ROOTFS_DIR}/etc/ssh/ssh_host_*_key*
