#!/bin/bash

#添加lienol feed源
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
cat feeds.conf.default |grep lienol
echo '====================Add lienol feed source OK!===================='

#添加jerryk feed源
#sed -i '$a src-git jerryk https://github.com/jerrykuku/openwrt-package' feeds.conf.default
#cat feeds.conf.default |grep jerryk
#echo '====================Add jerryk feed source OK!===================='

#修改内核版本为5.4
sed -i 's/KERNEL_PATCHVER:=4.19/KERNEL_PATCHVER:=5.4/g' target/linux/bcm53xx/Makefile
cat target/linux/bcm53xx/Makefile |grep KERNEL_PATCHVER
echo '====================Alert Kernel Patchver to 5.4 OK!===================='

#添加rufengsuixing的AdGuardHome插件
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/lean/luci-app-adguardhome
sed -i '1,$d' package/lean/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
echo 'https://static.adguard.com/adguardhome/release/AdGuardHome_linux_armv5.tar.gz'>>package/lean/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
cat package/lean/luci-app-adguardhome/root/usr/share/AdGuardHome/links.txt
echo '====================Add AdGuardHome Plug OK!===================='

#添加lwz322的K3屏幕插件
git clone https://github.com/lwz322/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
ls -la package/lean/ |grep luci-app-k3screenctrl
echo '====================Add k3screen Plug OK!===================='

#替换lwz322的K3屏幕驱动
rm -rf package/lean/k3screenctrl
git clone https://github.com/lwz322/k3screenctrl_build.git package/lean/k3screenctrl/
#sed -i 's/@TARGET_bcm53xx_DEVICE_phicomm-k3 +@KERNEL_DEVMEM //g' package/lean/k3screenctrl/Makefile
cat package/lean/k3screenctrl/Makefile |grep DEPENDS
echo '====================Add k3screen Drive OK!===================='

#替换K3的无线驱动
wget -nv https://github.com/Hill-98/phicommk3-firmware/archive/master.zip -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/master.zip
unzip package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/master.zip -d package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/
mv package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/phicommk3-firmware-master/brcmfmac4366c-pcie.bin.69027 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
rm -rf package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/master.zip
rm -rf package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/phicommk3-firmware-master
ls -la package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/ |grep 4366c
echo '====================Delete temp or release files!===================='

#移除bcm53xx的其他机型
sed -i '141,385d' target/linux/bcm53xx/image/Makefile
sed -i '150,179d' target/linux/bcm53xx/image/Makefile
sed -i 's/k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile
cat target/linux/bcm53xx/image/Makefile |grep DEVICE_PACKAGES
echo '====================Remove other devices of bcm53xx!===================='
