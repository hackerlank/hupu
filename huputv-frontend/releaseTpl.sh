#! /bin/bash

# 部署分支版本
VERSION = "master"

echo ">>>>>>>>>>All tpl start compile<<<<<<<";

ssh root@192.168.8.123 << remotessh
rm -rf /data/www-data/hupu.com/huputv_frontend/template_c/*;
php ~/complie.php;
cd /root/huputv-frontend;
git checkout -b $VERSION
git pull origin $VERSION;
cp -f /data/www-data/hupu.com/huputv_frontend/template_c/* /root/huputv-frontend/output/template_c/;
cd /root/huputv-frontend/output/template_c/;
git add *
git commit -m "frontend tpl auto commit"
git push origin $VERSION
remotessh

echo ">>>>>>>>>>All tpl end compile<<<<<<<";
