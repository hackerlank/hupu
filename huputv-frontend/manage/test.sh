#! /bin/bash
#git pull origin chaoneng
product="manage"
dist="./dist"
entry="index.html"
saplayer="saplayer.html"
host="192.168.8.123"
devServer="root@$host:/data/www-data/hupu.com/huputv_frontend/manage"
timestamp=$(date +%s)

echo ">>>>>>>>>>manage webpack start<<<<<<<";
npm run build;

echo ">>>>>manage scp to [ $devServer ]<<<<<";
cp $saplayer $dist/$product/static/
sed -e "s/\.\//\/$product\/static\//g" -e "s/\.css/&?t=$timestamp/g" -e "s/\.js/&?t=$timestamp/g" ./$entry > $dist/$product/$entry
cp huputv_1.swf $dist/$product/static/
scp -r $dist/$product/* $devServer
