# 文件拷贝
if [ -z "$(ls -A assets)" ];then
    echo "copy assets"
    cp -rf asset_back/* assets/
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
echo $xblog_host
# 修改默认配置文件

# 后台运行
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf