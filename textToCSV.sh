#!/bin/bash

while read -r line || [[ -n "$line" ]]
do
	curr=$(echo $line | rev | cut -d" " -f2- | rev)
	nb=$(echo $line | rev | cut -d" " -f1 | rev)

	if [ "$prev" != "$curr" ]
	then
		if [ "$prev" != "" ]
		then
			echo
		fi
		echo -n "$curr;$nb;"
		prev=$curr
	else
		echo -n "$nb;"
	fi

done < <(sort "$1")

