#!/bin/bash

cat $1 | tr -d "[:digit:]" | sed '/^$/d' | sort -u
