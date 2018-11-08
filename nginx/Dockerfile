FROM alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories &&\
    apk --no-cache upgrade &&\
    apk --no-cache add openrc nginx &&\
# 设置虚拟主机配置文件目录
    sed -i 's/^\([ \t]*include \)\/etc\/nginx\/conf.d\/\*\.conf\;/\1\/data\/_proxy\/*.conf;/g' /etc/nginx/nginx.conf &&\
# 设置默认日志文件目录
    sed -i 's/^\([ \t]*error_log \).*/\1\/data\/_proxy\/log\/nginx.error.log warn;/g' /etc/nginx/nginx.conf &&\
    sed -i 's/^\([ \t]*access_log \).*/\1\/data\/_proxy\/log\/nginx.access.log main;/g' /etc/nginx/nginx.conf &&\
# 去除对net服务的依赖
    sed -i 's/^\([ \t]*\)\(need net\)$/\1#\2/g' /etc/init.d/nginx &&\
# 添加服务
    rc-update add nginx default &&\
# 取消默认启动的tty
    sed -i 's/^\([ \t]*tty\d.*\)/\#\1/g' /etc/inittab
# 添加入口
CMD ["/sbin/init"]

