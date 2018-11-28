#!/bin/bash

if [ $# -ne 1 ]
then
	echo wrong number of parameters !
	exit
fi

for file in "$1"/*png
do
	path=$(dirname "$file")
	new=$(stat -c %x "$file" | { read gmt; date -d "$gmt" +%Y.%m.%d-%H.%M.%S.%N; })
	mv -v "$file" "$path/${new:0:24}.png"
done
