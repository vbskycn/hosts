#!/bin/sh

# 使用 while 循环逐行读取输出，并将每一行的 HOST 进行处理
cat /etc/hosts | grep -v "127.0.0.1\|::1\|^$" | while IFS= read -r HOST; do
    sed -i "/$HOST/d" /etc/hosts
done
