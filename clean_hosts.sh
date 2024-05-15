#!/bin/sh

LOCAL_HOST_LIST=`cat /etc/hosts | grep -v "127.0.0.1\|::1\|^$"`

for HOST in $LOCAL_HOST_LIST; do

      sed -i "/$HOST/d" /etc/hosts

done