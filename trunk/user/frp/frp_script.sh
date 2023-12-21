#!/bin/sh
#from hiboy
killall frpc frps
mkdir -p /tmp/frp
#启动frp功能后会运行以下脚本
#frp项目地址教程: https://github.com/fatedier/frp/blob/master/README_zh.md
#请自行修改 token 用于对客户端连接进行身份验证
# IP查询： http://119.29.29.29/d?dn=github.com

cat > "/tmp/frp/myfrpc.ini" <<-\EOF
# ==========客户端配置：==========
[common]
server_addr = 域名
server_port = 7000
token = hjgidfsdfsd5615fsdgsd

[web]
remote_port = 6000
type = tcp
local_ip = 0.0.0.0
local_port = 80
# ====================
EOF

#请手动配置【外部网络 (WAN) - 端口转发 (UPnP)】开启 WAN 外网端口
cat > "/tmp/frp/myfrps.ini" <<-\EOF
# ==========服务端配置：==========
[common]
bind_port = 7000
dashboard_port = 7500
dashboard_user = admin
dashboard_pwd = admin
token = hjgidfsdfsd5615fsdgsd
allow_ports = 10000-60000
# ====================
EOF

#启动：
frpc_enable=`nvram get frpc_enable`
frps_enable=`nvram get frps_enable`
if [ "$frpc_enable" = "1" ] ; then
    frpc -c /tmp/frp/myfrpc.ini 2>&1 &
fi
if [ "$frps_enable" = "1" ] ; then
    frps -c /tmp/frp/myfrps.ini 2>&1 &
fi
 
