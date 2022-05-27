# 删除掉不需要的东西
rm -rf _nuxt admin api assets configs plugins static themes upload xblog index.php main themes_back assets_back configs_back plugins_back
export CGO_ENABLED=0

echo "开始下载项目。。。"
# 下载xblog的镜像
git clone http://gitea.xiaoyou.com/xiaoyou/xblog.git
# 先把Web目录下的内容拷贝出来
cp -R xblog/web/* .
# 然后再拷贝api的
cp -R xblog/api .

echo "编译项目中。。。"
# 编译GO项目
cd api
/usr/local/go/bin/go build main.go
cd ..

echo "拷贝文件夹中。。。"
# 把需要的内容拷贝出来
cp -R api/assets .
cp -R api/configs .
cp -R api/plugins .
cp -R api/upload .
cp api/main main

echo "修改配置文件。。"
# 修改config的配置文件
sed -i "s/localhost/host.docker.internal/g" configs/app.ini
# 设置权限
sudo chmod -R 777 ./*
# 修改文件名字，避免映射时文件夹丢失
cp -R themes themes_back
cp -R assets assets_back
cp -R configs configs_back
cp -R plugins plugins_back

echo "删除旧镜像"
container=$(sudo docker ps -a | grep xblog | awk '{print $1}')
images=$(sudo docker images | grep xblog | awk '{print $3}')
# 判断一下容器是否正在运行
if [[ -n "$container" ]]; then
    sudo docker rm -f $container
fi
if [[ -n "$images" ]]; then
    sudo docker rmi -f $images
fi

echo "构建镜像中。。。"
sudo docker build -t xblog .


echo "运行容器。。。"
sudo docker run -itd --add-host=host.docker.internal:host-gateway \
-v /www/wwwroot/xblog/assets:/var/www/html/assets \
-v /www/wwwroot/xblog/configs:/var/www/html/configs \
-v /www/wwwroot/xblog/plugins:/var/www/html/plugins \
-v /www/wwwroot/xblog/themes:/var/www/html/themes \
-v /www/wwwroot/xblog/upload:/var/www/html/upload \
-p 2334:80 -e xblog_host="http://xblog.xiaoyou.com" --name xblog xblog 