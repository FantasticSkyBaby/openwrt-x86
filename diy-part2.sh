#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.199.1/g' package/base-files/files/bin/config_generate

# Tailscale LuCI support
echo "===== Configuring luci-app-tailscale ====="

# Remove files from the official tailscale package
# because luci-app-tailscale provides them.
if [ -f feeds/packages/net/tailscale/Makefile ]; then
    sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' \
        feeds/packages/net/tailscale/Makefile
fi

# Verify
echo "===== tailscale Makefile ====="
grep -n -A30 -B5 "define Package/tailscale/install" \
    feeds/packages/net/tailscale/Makefile || true

echo "===== luci-app-tailscale files ====="
find feeds package -type f \( \
    -path "*/luci-app-tailscale/root/etc/config/tailscale" -o \
    -path "*/luci-app-tailscale/root/etc/init.d/tailscale" \
\) -print 2>/dev/null || true
