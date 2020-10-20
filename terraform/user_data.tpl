#!/bin/bash

echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1' | tee  /etc/yum.repos.d/nginx.repo
yum -y install nginx
echo "<h1>Hello World</h1>" > /usr/share/nginx/html/index.html
systemctl enable nginx
systemctl start nginx
