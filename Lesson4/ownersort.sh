#! /bin/bash

cd $1

usernames=$(ls -l | grep -v ^total | sed 's/\s\s*\s/ /g' | cut -d ' ' -f 3 | sort | uniq)
for username in $usernames
do 
    userfiles=$(ls -l | sed 's/\s\s*\s/ /g' | cut -d ' ' -f 3,9 | sort | grep ^$username | cut -d ' ' -f 2)
    mkdir $username
    cp $userfiles $username/ -r
done

