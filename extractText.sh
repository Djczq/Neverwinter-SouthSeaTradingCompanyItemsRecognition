#!/bin/bash

#sudo apt-get install imagemagick tesseract-ocr-fra tesseract-ocr-eng
set -e

if [ $# -ne 4 ]
then
	echo wrong number of parameters !
	exit
fi

input="$1"

id=( $(identify "$input") )
nbX=$2
nbY=$3
inf=$4

cut=( $(echo ${id[2]} | tr "x" "\n") )

xcut=$(( ${cut[0]} / $nbX ))
ycut=$(( ${cut[1]} / $nbY ))

x2=$(( 10 * $xcut / 38 ))

if [ "$inf" = "all" ]
then
	y2=0
else
	y2=$(( $ycut / 2 ))
fi

for ((j=0; j<$nbY; j++))
do
	for ((i=0; i<$nbX; i++))
	do
		nb=$(( $j * $nbX + $i ))
		output="${input#*-}"
		output="${output%.*}"
		output=res-$output-$nb.png
		convert "$input" -crop $(($xcut - $x2))\x$(($ycut - $y2))+$(($i * $xcut + $x2))+$(($j * $ycut)) "$output"
		tesseract "$output" stdout | tr "\n" " " | tr -d ",\|&#:Æ=" | sed -e 's/\+1//g' | tr -s " " | sed -e 's/^\s*//g;s/\s*$//g'
		echo
	done
done

