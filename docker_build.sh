# # 删除掉不需要的东西
echo "开始下载项目。。。"
# rm -rf _nuxt admin api assets configs plugins static themes upload xblog index.php main
# # 下载xblog的镜像
# git clone http://gitea.xiaoyou.com/xiaoyou/xblog.git
# # 先把Web目录下的内容拷贝出来
# cp -R xblog/web/* .
# # 然后再拷贝api的
# cp -R xblog/api .
echo "编译项目中。。。"
# # 编译GO项目
# cd api && go build main.go
# # 返回上一季目录
# cd ..
# # 把需要的内容拷贝出来
# cp -R api/assets .
# cp -R api/configs .
# cp -R api/plugins .
# cp -R api/upload .
# cp api/main main

echo "删除旧镜像"
container=$(sudo docker ps -a | grep xblog | awk '{print $1}')
images=$(sudo docker images | grep xblog | awk '{print $3}')
# 判断一下容器是否正在运行
if [[ -n "$images" ]]; then
    sudo docker rmi -f $images
fi
if [[ -n "$container" ]]; then
    sudo docker rm -f $container
fi
# echo $images

echo "构建镜像中。。。"
sudo docker build -t xblog .
# # 运行docker
sudo docker run -itd --add-host=host.docker.internal:host-gateway -p 92:8080 --name xblog xblog 