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

# 新增 IPv4 网关
# 在 zzz-default-settings 中设置网关与 DNS
sed -i '/exit 0/i \
uci set network.lan.gateway="192.168.199.3"\n\
uci set network.lan.dns="192.168.199.3"\n\
uci commit network\n' package/lean/default-settings/files/zzz-default-settings
