#! /bin/bash
#svn up
# 模块
MODULES=("common live app")

for mod in ${MODULES[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
fis3 release dev104
cd ..;
sleep 1;
done
echo "==========All build end========"
