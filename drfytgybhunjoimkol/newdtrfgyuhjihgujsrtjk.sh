
Happy_Bt(){
echo "44.234.251.213 www.bt.cn" >>  /etc/hosts && chattr +i /etc/hosts
sed -i "s/time.localtime(ltd)/time.localtime(7955085722)/"  /www/server/panel/BTPanel/__init__.py
curl -s -o /dev/null www.bt.cn
wget -qO /www/server/panel/data/plugin.json http://www.bt.cn/api/panel/get_soft_list_test
echo "True" > /www/server/panel/data/licenes.pl
}

Is_Set_(){
read -p "设置面板后台入口（留空或者n随机 默认随机）" admin_path
read -p "设置后台账户（留空或者n随机 默认随机） >3位" admin_
read -p "设置后台密码（留空或者n随机 默认随机）>5位" admin_pwd
}

Change_Path(){
echo "/$1" > /www/server/panel/data/admin_path.pl
}

Change_Admin(){
bt << EOF
6
$2
EOF
}

Change_Passwd(){
bt << EOF
5
$3
EOF
}

curl -sSO http://download.bt.cn/install/install_panel.sh && bash install_panel.sh
Happy_Bt
[[ -n $1 ]] && Change_Path
[[ -n $2 ]] && Change_Admin
[[ -n $3 ]] && Change_Passwd
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
iptables -I INPUT -p udp -m state --state NEW -m udp --dport 443 -j ACCEPT
