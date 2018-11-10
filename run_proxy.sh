#!/bin/bash

NAMESPACE=liyi

while getopts "c:" opt;
do
    case $opt in
        c)
            c=$OPTARG
            ;;
        \?)
            echo "无效的选项: -$OPTARG"
            ;;
    esac
done

if [ "$c" = "" ]; then
    echo "参数错误 [ -c 配置文件目录 ]"
    exit 1
fi

echo "配置文件目录: $c"

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO} docker run \
    --net host \
    --name _proxy \
    --restart always \
    -d \
    -v ${c}:/data/_proxy \
    ${NAMESPACE}/nginx

