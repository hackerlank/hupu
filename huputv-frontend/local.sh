#! /bin/bash
svn up
# 模块
MODULES=("common" "home" "live" "obs")
 
rm -rf output/*

for mod in ${MODULES[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
fis3 release local
cd ..;
sleep 1;
done

echo "==========All local end========"
