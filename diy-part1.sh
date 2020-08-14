#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

#修改内核版本为5.4
sed -i 's/4.19/5.4/g' target/linux/bcm53xx/Makefile
cat target/linux/bcm53xx/Makefile |grep KERNEL_PATCHVER

#添加rufengsuixing的AdGuardHome插件
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/rufengsuixing

#添加likanchen的K3屏幕插件
git clonehttps://github.com/likanchen/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl

#替换likanchen的K3屏幕驱动
rm -rf package/lean/k3screenctrl
git clone https://github.com/likanchen/k3screenctrl_build.git package/lean/k3screenctrl/
sed -i 's/@TARGET_bcm53xx_DEVICE_phicomm-k3 +@KERNEL_DEVMEM +//g' package/lean/k3screenctrl_build/Makefile

#替换K3的无线驱动
wget https://github.com/Hill-98/phicommk3-firmware/archive/master.zip -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/master.zip
unzip package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/master.zip -d package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/
rm -rf package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/master.zip
echo 'delete wget zip file'
mv package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/phicommk3-firmware-master/brcmfmac4366c-pcie.bin.69027 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
echo 'instead of k3-firmware'
rm -rf package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/phicommk3-firmware-master
echo 'delete release files'
