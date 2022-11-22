#!/bin/bash

while getopts :ab:c opt
do
  case $opt in
    a)
     echo a option;;
    b)
     echo b option,param:$OPTARG;;
    c)
     echo c option;;
    *)
     echo unknown option:$opt;;
  esac
done

shift $[$OPTIND-1]

echo start handle param:

for param in "$@"
do
 echo $param
done
