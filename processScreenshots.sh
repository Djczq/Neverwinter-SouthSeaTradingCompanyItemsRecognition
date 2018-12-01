#!/bin/bash
set -e

if [ $# -ne 2 ]
then
	echo wrong number of parameters
	exit 1
fi

x1=160
x2=541
y1=215
y2=836

xcut=$(( $x2 - $x1 ))
ycut=$(( $y2 - $y1 ))

inf=$2

rm -f *png

for file in "$1"/*
do
	output=$(basename "$file")
	output="crop-${output%.*}.png"
	convert "$file" -crop $xcut\x$ycut+$x1+$y1 -fuzz 8% -trim +repage -interpolative-resize 250% +repage -negate "$output"
	./extractText.sh "$output" 2 7 $inf
done > output.raw 2> error.log

if [ $inf = "all" ]
then
	./textToCSV.sh output.raw > output.csv
fi
./textToList.sh output.raw > output.list
