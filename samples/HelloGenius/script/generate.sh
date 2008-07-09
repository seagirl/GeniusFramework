#!/bin/sh

type='type';
name='';
output='./';

while getopts "t:n:o:h" opt
do
  case $opt in
    t ) type=$OPTARG;;
    n ) name=$OPTARG;;
    o ) output=$OPTARG;;
    h ) echo 'You can use options below.
    	-t type "Command" or "Model" or "View"
    	-n name ex) ThreePane
    	-o output
    	';;
    ? ) echo 'usage -h';
    	exit;;
  esac
done

# カレントディレクトリ
a=${0%/*};
b=${a%/*};

if [ $a != $b ]
then
	current=$b/script;
else
	current='.';
fi

if [ $current != '.' ]
then
	exit;
fi

if [ $type = 'type' ]
then
	echo '"type" must be specified. use "-t"';
	exit;
elif [ $type = 'Model' ]
then
	
	echo created ../src/jp/seagirl/sample/models/${name}Model.as;
elif [ $type = 'View' ]
then
	echo 'View' $current;
else
	echo 'type must be "Model" or "View".';
	exit;
fi

exit;