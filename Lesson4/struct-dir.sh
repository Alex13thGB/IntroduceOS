#! /bin/bash

for y in {2015..2020}
do
    for m in {01..12}
    do
        mkdir -p $y/$m
        for f in {000..0010}
        do
            echo Файл $f.txt > $y/$m/$f.txt
        done
    done
done