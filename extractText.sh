#!/bin/bash

#sudo apt-get install imagemagick tesseract-ocr-fra
lang=fra

set -e


if [ $# -ne 3 ]
then
	echo wrong number of parameters !
	exit
fi

input="$1-input.png"
convert "$1" -unsharp 3 -noise 2 -negate -despeckle -monochrome -equalize "$input"

id=( $(identify "$input") )
nbX=$2
nbY=$3

cut=( $(echo ${id[2]} | tr "x" "\n") )

xcut=$(( ${cut[0]} / $nbX ))
ycut=$(( ${cut[1]} / $nbY ))

x2=$(( 10 * $xcut / 38 ))
y2=$(( $ycut / 2 ))

yd=$(($ycut * 12 / 100))

for ((j=0; j<$nbY; j++))
do
	for ((i=0; i<$nbX; i++))
	do
		nb=$(( $j * $nbX + $i ))
		#echo "$1-res$nb.png"
		convert "$input" -crop $(($xcut - $x2))\x$(($ycut - $y2 - $yd))+$(($i * $xcut + $x2))+$(($j * $ycut + $yd)) "$1-res$nb.png"
		#convert "$1-res$nb.png" -fuzz 6% -trim +repage "$1-res$nb.png"
		tesseract "$1-res$nb.png" stdout -l "$lang" | tr "\n" " " | tr -d ",\|&+#:;!?[:digit:]{}" | tr -s " " | sed -e 's/^\s*//g;s/\s*$//g'
		echo
	done
done

