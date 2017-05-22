#!/bin/bash -e

sed -i "s/YOUR_NETWORK_NAME/${NETWORK}/g" files/wpa_supplicant.conf
sed -i "s/YOUR_NETWORK_PASSWORD/${PASSWORD}/g" files/wpa_supplicant.conf

install -v -d						${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d
install -v -m 644 files/wait.conf			${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/

install -v -d                                           ${ROOTFS_DIR}/etc/wpa_supplicant
install -v -m 600 files/wpa_supplicant.conf             ${ROOTFS_DIR}/etc/wpa_supplicant/

