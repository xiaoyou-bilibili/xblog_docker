# 文件拷贝
if [ -z "$(ls -A assets)" ];then
    echo "copy assets"
    cp -rf assets_back/* assets/
fi
if [ -z "$(ls -A configs)" ];then
    echo "copy configs"
    cp -rf configs_back/* configs/
fi
if [ -z "$(ls -A plugins)" ];then
    echo "copy plugins"
    cp -rf plugins_back/* plugins/
fi
if [ -z "$(ls -A themes)" ];then
    echo "copy themes"
    cp -rf themes_back/* themes/
fi
# 修改默认配置文件
phpIndex="index.php"
config=$(cat $phpIndex|grep "SERVER = \".*\"")
config=${config: 20: -3}
# 字符串转义
config=${config//\//\\\/}
service=${xblog_host//\//\\\/}
# 修改配置文件
sed -i "s/${config}/${service}/g" index.php
# 后台运行
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf