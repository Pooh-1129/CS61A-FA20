#!/bin/bash
for file in ./*
do
	if test -d $file
	then
		cd $file
		python3 ok --local
		cd ..
	fi
done
