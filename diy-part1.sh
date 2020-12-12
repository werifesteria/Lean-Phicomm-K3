#!/bin/bash

#添加xiaorouji的passwall软件源
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
cat feeds.conf.default |grep passwall
echo '====================Add lienol feed source OK!===================='

#修改linux内核为5.4分支
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

#移除bcm53xx中的其他机型
sed -i '141,385d' target/linux/bcm53xx/image/Makefile
sed -i '150,179d' target/linux/bcm53xx/image/Makefile
sed -i 's/k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile
cat target/linux/bcm53xx/image/Makefile |grep DEVICE_PACKAGES
echo '====================Remove other devices of bcm53xx!===================='

#替换K3的无线驱动为ac86u
#wget -nv https://github.com/Hill-98/phicommk3-firmware/raw/master/brcmfmac4366c-pcie.bin.ac88u
#mv brcmfmac4366c-pcie.bin.ac88u package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#chmod 0644 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#echo '====================Replace k3wireless firmware OK!===================='

#替换K3的无线驱动为asus-dhd24
wget -nv https://github.com/Hill-98/phicommk3-firmware/raw/master/brcmfmac4366c-pcie.bin.asus-dhd24
mv brcmfmac4366c-pcie.bin.asus-dhd24 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#chmod 0644 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
echo '====================Replace k3wireless firmware OK!===================='

#替换K3的无线驱动为69027
#wget -nv https://github.com/Hill-98/phicommk3-firmware/raw/master/brcmfmac4366c-pcie.bin.69027
#mv brcmfmac4366c-pcie.bin.69027 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#chmod 0644 package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
#echo '====================Replace k3wireless firmware OK!===================='
