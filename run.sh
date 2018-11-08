#!/bin/bash

NAMESPACE=liyi

while getopts "i:n:d:p:" opt;
do
    case $opt in
        i)
            i=$OPTARG
            ;;
        n)
            n=$OPTARG
            ;;
        d)
            d=$OPTARG
            ;;
        p)
            p=$OPTARG
            ;;
        \?)
            echo "无效的选项: -$OPTARG"
            ;;
    esac
done

if [ "$i" = "" ] || [ "$n" = "" ] || [ "$d" = "" ] || [ "$p" = "" ]; then
    echo "参数错误 [ -i 镜像名称 -n 容器名称 -d 文件目录 -p 容器端口 ]"
    exit 1
fi

echo "镜像名称: $i"
echo "容器名称: $n"
echo "文件目录: $d"
echo "容器端口: $p"

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO} docker run \
    --name ${n} \
    --restart always \
    -d \
    -v ${d}/log:/data/log \
    -v ${d}/www:/data/www:ro \
    -v ${d}/vhost:/data/vhost:ro \
    -p ${p}:80 \
    ${NAMESPACE}/${i}

