killall frps
mkdir -p /tmp/frp
#请自行修改 token 用于对客户端连接进行身份验证
#请手动配置【外部网络 (WAN) - 端口转发 (UPnP)】开启 WAN 外网端口
cat > "/tmp/frp/myfrps.ini" <<-\EOF
# ==========服务端配置：==========
[common]
bind_port = 7000
dashboard_port = 7500
dashboard_user = admin
dashboard_pwd = admin
tcp_mux = true
token = 6ui5yu103sdf1we65
allow_ports = 10000-60000
# ================================
EOF

#启动frps
frps_enable=`nvram get frps_enable`
if [ "$frps_enable" = "1" ] ; then
    frps -c /tmp/frp/myfrps.ini 2>&1 &
fi
