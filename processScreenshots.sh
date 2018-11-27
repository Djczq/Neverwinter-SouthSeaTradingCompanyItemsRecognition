#!/bin/bash
set -e

x1=160
x2=541
y1=215
y2=836

xcut=$(( $x2 - $x1 ))
ycut=$(( $y2 - $y1 ))

rm -f results.txt
rm -f *png

for file in "$1"/*
do
	output=$(basename "$file")
	output="${output%.*}-crop.png"
	convert "$file" -crop $xcut\x$ycut+$x1+$y1 -fuzz 8% -trim +repage -interpolative-resize 250% +repage "$output"
	./extractText.sh "$output" 2 7 >> results.txt
done