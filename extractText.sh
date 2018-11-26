#!/bin/bash

#sudo apt-get install imagemagick tesseract-ocr-fra
lang=fra


if [ $# -ne 3 ]
then
	echo wrong number of parameters !
	exit
fi

convert "$1" -level 100%,0 -fuzz 5% -trim +repage input.png
#-flatten -fuzz 15%
input=input.png


id=( $(identify "$input") )
nbX=$2
nbY=$3

cut=( $(echo ${id[2]} | tr "x" "\n") )

xcut=$(( ${cut[0]} / $nbX ))
ycut=$(( ${cut[1]} / $nbY ))

x2=$(( 10 * $xcut / 35 ))
y2=$(( $ycut / 2 ))

for ((j=0; j<$nbY; j++))
do
	for ((i=0; i<$nbX; i++))
	do
		nb=$(( $j * $nbX + $i ))
		#convert "$input" -crop $(($xcut - $x2))\x$(($ycut - $y2))+$(($i * $xcut + $x2))+$(($j * $ycut)) res$nb.png
		convert "$input" -crop $(($xcut - $x2))\x$ycut+$(($i * $xcut + $x2))+$(($j * $ycut)) res$nb.png
		#convert res$nb.png -fuzz 5% -trim +repage res$nb.png
		tesseract res$nb.png stdout -l "$lang" | tr "\n" " " | tr -d ",\|&+1" | tr -s " " | sed -e 's/^\s*//g;s/\s*$//g'
		echo
	done
done

rm res*.png
