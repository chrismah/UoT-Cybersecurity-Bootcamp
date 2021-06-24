#!/bin/bash
date=$1
time=$2
game=$3
filename=$1'_Dealer_schedule'

grep "$time" $filename | cut -d$'\t' -f2-4 | cut -d$'\t' -f$game