#! /bin/bash

#编译环境
#安装nodejs, 版本>=0.10.30
#安装npm，版本>=2.1.6

#安装全局的fis命令，fisp命令，如果安装好了，不必重复安装.
#npm install fis -g;
#npm install fis-plus -g;
#fis,版本>=1.9.17
#fisp,版本>=0.8.6

#还依赖npm的全局包
#npm install fis-parser-sass -g

#编译本地前端代码模块
#如果有新的模块，在后面添加
modules=("common" "match" "team")
cdn="online"
for mod in ${modules[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
fisp release -Dompd $cdn;
cd ..;
done
echo ">>>>>>>>>>All modules is released!<<<<<<<<<<<";


