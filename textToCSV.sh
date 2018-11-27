#!/bin/bash

while read -r line || [[ -n "$line" ]]
do
	end="${line: -1}"

	if [[ "$end" =~ [0-9] ]]
	then
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
	else
		curr=$line
		if [ "$prev" != "$curr" ]
		then
			if [ "$prev" != "" ]
			then
				echo
			fi
			echo -n "$curr;"
			prev=$curr
		fi
	fi

done < <(sort "$1")
echo

