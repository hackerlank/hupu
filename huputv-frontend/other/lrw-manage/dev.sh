#! /bin/bash
#git pull origin chaoneng

product="lrw_manage"
dist="./dist"
entry="index.html"
# host="192.168.8.112"
host="192.168.8.104"
#host="192.168.11.103"
devServer="root@$host:/data/www-data/hupu.com/huputv_frontend/$product"

echo ">>>>>>>>>>$product webpack start<<<<<<<";
npm run build;

echo ">>>>>$product scp to [ $devServer ]<<<<<";
scp -r $dist/$product/* $devServer

# rm -rf $dist