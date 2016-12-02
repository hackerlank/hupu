#! /bin/bash

product="zhubo"
dist="./dist"
entry="index.html"
host="192.168.8.104"
devServer="root@$host:/data/www-data/hupu.com/huputv_frontend/$product"

echo ">>>>>>>>>>manage webpack start<<<<<<<";
npm run build;

echo ">>>>>manage scp to [ $devServer ]<<<<<";
scp -r $dist/$product/* $devServer
