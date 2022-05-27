# 博客系统docker版本

原项目：https://github.com/xiaoyou-bilibili/xblog

## 简单使用
> 适合只想体验的用户

```bash
sudo docker run -itd --add-host=host.docker.internal:host-gateway -p 2334:80 --name xblog registry.cn-hangzhou.aliyuncs.com/xiaoyou66/xblog 
```

访问: http://ip:2334 即可

## 路径映射
> 如果想容器删除后即可以继续使用，需要把一些常用的路径给映射出来

`/www/wwwroot/xblog` 是我们的服务器上的路径，自己需要给这些文件夹都加上`777`的权限，要不然会无法访问

```bash
sudo docker run -itd --add-host=host.docker.internal:host-gateway \
-v /www/wwwroot/xblog/assets:/var/www/html/assets \
-v /www/wwwroot/xblog/configs:/var/www/html/configs \
-v /www/wwwroot/xblog/plugins:/var/www/html/plugins \
-v /www/wwwroot/xblog/themes:/var/www/html/themes \
-v /www/wwwroot/xblog/upload:/var/www/html/upload \
-p 2334:80 --name xblog registry.cn-hangzhou.aliyuncs.com/xiaoyou66/xblog 
```

## 域名访问

可以使用nginx的反向代理，注意需要加上： `underscores_in_headers on;` 要不然会无法正常登录。

如果想让安卓的聊天室正常功能，反向代理需要支持 http1.1 ，请在location里面加上下面这个。
```bash
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "Upgrade";
```
