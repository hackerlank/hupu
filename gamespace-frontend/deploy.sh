#! /bin/bash
#svn up
qiumodules=("common" "team" "match")

#dev="dev"
if [ "x$1" == "xdev" ]; then
  dev="dev"
else
  dev="test"
fi

for mod in ${qiumodules[@]}
do
echo "It's ready to release [$mod] ...";
cd $mod;
#fisp release -Dopmd $dev;
fisp release -opmd $dev;
cd ..;
done
echo ">>>>>>>>>>All modules is released!<<<<<<<<<<<";

#当前文件夹下产出的 output 文件夹就是要的东西了.
#根据服务器的部署路径，修改下路径.
