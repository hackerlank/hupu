#! /bin/bash
#svn up
# 模块
MODULES=("common live home app")

for mod in ${MODULES[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
fis3 release qa123
cd ..;
sleep 1;
done

echo "==========All build end========"
