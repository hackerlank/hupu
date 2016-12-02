#! /bin/bash
#svn up
# 模块
MODULES=("common" "home" "live" "obs" "app")

for mod in ${MODULES[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
fis3 release online
cd ..;
sleep 1;
done

cpPath="../b1/web/tv"

mkdir -p $cpPath
cp -r ./output/static/tv/** $cpPath

echo "==========All online end========"
