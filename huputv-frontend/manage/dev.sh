#! /bin/bash
#git pull origin chaoneng

product="manage"
dist="./dist"
entry="index.html"
# host="192.168.8.112"
host="192.168.8.104"
#host="192.168.11.103"
devServer="root@$host:/data/www-data/hupu.com/huputv_frontend/manage"

echo ">>>>>>>>>>manage webpack start<<<<<<<";
npm run build;

echo ">>>>>manage scp to [ $devServer ]<<<<<";
sed -e "s/\.\//\/$product\/static\//g" ./$entry > $dist/$product/$entry
cp huputv.swf $dist/$product/static/
scp -r $dist/$product/* $devServer
