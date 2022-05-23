# 拷贝PHP的镜像
FROM trafex/php-nginx:latest
# 设置工作目录，也就是那个HTTP的目录
WORKDIR /var/www/html