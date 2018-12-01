#!/bin/bash
set -e

x1=160
x2=541
y1=215
y2=836

xcut=$(( $x2 - $x1 ))
ycut=$(( $y2 - $y1 ))

rm -f *png

for file in "$1"/*
do
	output=$(basename "$file")
	output="crop-${output%.*}.png"
	convert "$file" -crop $xcut\x$ycut+$x1+$y1 -fuzz 8% -trim +repage -interpolative-resize 250% +repage -negate "$output"
	./extractText.sh "$output" 2 7
done > output.raw 2> error.log

./textToCSV.sh output.raw > output.csv
