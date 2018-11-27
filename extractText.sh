#!/bin/bash

#sudo apt-get install imagemagick tesseract-ocr-fra
lang=fra

set -e

if [ $# -ne 3 ]
then
	echo wrong number of parameters !
	exit
fi

input="$1"

id=( $(identify "$input") )
nbX=$2
nbY=$3

cut=( $(echo ${id[2]} | tr "x" "\n") )

xcut=$(( ${cut[0]} / $nbX ))
ycut=$(( ${cut[1]} / $nbY ))

x2=$(( 10 * $xcut / 38 ))

for ((j=0; j<$nbY; j++))
do
	for ((i=0; i<$nbX; i++))
	do
		nb=$(( $j * $nbX + $i ))
		output="${input#*-}"
		output="${output%.*}"
		output=res-$output-$nb.png
		convert "$input" -crop $(($xcut - $x2))\x$ycut+$(($i * $xcut + $x2))+$(($j * $ycut)) "$output"
		tesseract "$output" stdout -l "$lang" | tr "\n" " " | tr -d ",\|&#:" | sed -e 's/\+1//g' | tr -s " " | sed -e 's/^\s*//g;s/\s*$//g'
		echo
	done
done

