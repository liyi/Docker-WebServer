FROM alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories &&\
    apk --no-cache upgrade &&\
    apk --no-cache add openrc \
# 安装php7和nginx
    php7-fpm php7-curl php7-json php7-pdo_mysql php7-mbstring php7-gd \
    nginx &&\
# 设置nginx配置文件目录
    sed -i 's/^\([ \t]*include \)\/etc\/nginx\/conf.d\/\*\.conf\;/\1\/data\/vhost\/*.conf;/g' /etc/nginx/nginx.conf &&\
# 设置默认日志文件目录
    sed -i 's/^\;*[ \t]*\(error_log *= *\).*/\1\/data\/log\/php7.error.log/g' /etc/php7/php-fpm.conf &&\
    sed -i 's/^\([ \t]*error_log \).*/\1\/data\/log\/nginx.error.log warn;/g' /etc/nginx/nginx.conf &&\
    sed -i 's/^\([ \t]*access_log \).*/\1\/data\/log\/nginx.access.log main;/g' /etc/nginx/nginx.conf &&\
# 修改php7监听参数
    sed -i 's/^\([ \t]*listen *= *\).*/\1\/dev\/shm\/php-fpm.sock/g' /etc/php7/php-fpm.d/www.conf &&\
# 修改php7的socket相关权限
    sed -i 's/^\;\?[ \t]*\(listen\.\owner *= *\).*/\1nobody/g' /etc/php7/php-fpm.d/www.conf &&\
    sed -i 's/^\;\?[ \t]*\(listen\.\group *= *\).*/\1nobody/g' /etc/php7/php-fpm.d/www.conf &&\
    sed -i 's/^\;\?[ \t]*\(listen\.\mode *= *\).*/\10666/g' /etc/php7/php-fpm.d/www.conf &&\
# 去除对net服务的依赖
    sed -i 's/^\([ \t]*\)\(need net\)$/\1#\2/g' /etc/init.d/php-fpm7 &&\
    sed -i 's/^\([ \t]*\)\(need net\)$/\1#\2/g' /etc/init.d/nginx &&\
# 添加服务
    rc-update add php-fpm7 default &&\
    rc-update add nginx default &&\
# 取消默认启动的tty
    sed -i 's/^\([ \t]*tty\d.*\)/\#\1/g' /etc/inittab
# 添加入口
CMD ["/sbin/init"]
