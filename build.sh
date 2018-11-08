#!/bin/bash

NAMESPACE=liyi

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

# 构建镜像
${SUDO} docker build --no-cache -t ${NAMESPACE}/php7 ./php7
${SUDO} docker build --no-cache -t ${NAMESPACE}/nginx ./nginx

