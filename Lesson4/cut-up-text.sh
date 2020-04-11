#! /bin/bash

if [ -z $1 ] 
then
    echo File isn\'t defined
elif [ -e $1 ]
then
    sed '/^$/d' -i $1
    if [ $? == 0 ]
    then
        sed -r 's/(.?)/\U\1/g' -i $1 
        if [ $? == 0 ]
        then
            echo File converted
        fi
    fi
else
    echo No such file
fi