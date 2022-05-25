# 拉取php镜像
FROM trafex/php-nginx
# 设置工作目录
WORKDIR /var/www/html
# 把项目里面的文件全部拷贝到docker中
COPY . .
# 配置文件拷贝
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
# 运行命令
CMD [ "sh", "./startup.sh" ]