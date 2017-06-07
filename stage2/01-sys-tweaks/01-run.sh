#!/bin/bash -e
mkdir -p ${ROOTFS_DIR}/home/pi/app/logocontrol
mkdir -p ${ROOTFS_DIR}/home/pi/app/mysql
mkdir -p ${ROOTFS_DIR}/home/pi/app/logs
install -m 755 -c files/docker.sh   			${ROOTFS_DIR}/home/pi/app/
install -m 755 -c files/dbsetup.sh   			${ROOTFS_DIR}/home/pi/app/
install -m 755 -c files/java.sh   			${ROOTFS_DIR}/home/pi/app/
touch ${ROOTFS_DIR}/home/pi/app/logs/app.log
mv files/*.war   			${ROOTFS_DIR}/home/pi/app/
sudo chown -R pi:pi /home/pi
install -m 644 files/regenerate_ssh_host_keys.service	${ROOTFS_DIR}/lib/systemd/system/
install -m 755 files/apply_noobs_os_config		${ROOTFS_DIR}/etc/init.d/
install -m 755 files/resize2fs_once			${ROOTFS_DIR}/etc/init.d/

install -d						${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d
install -m 644 files/ttyoutput.conf			${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d/

install -m 644 files/50raspi				${ROOTFS_DIR}/etc/apt/apt.conf.d/

install -m 644 files/console-setup   			${ROOTFS_DIR}/etc/default/
install -m 644 -c files/crontab   			${ROOTFS_DIR}/etc/


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
curl -sSL https://get.docker.com | sh
yes | sudo apt-get update
yes | sudo apt-get install oracle-java8-jdk
EOF

rm -f ${ROOTFS_DIR}/etc/ssh/ssh_host_*_key*
