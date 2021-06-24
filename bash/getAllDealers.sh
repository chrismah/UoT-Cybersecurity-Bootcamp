#!/bin/bash
date=$1
time=$2
filename=$date'_times'

while read line; do

./getDealer.sh $1 "$line"

done < $filename