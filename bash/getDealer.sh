#!/bin/bash
date=$1
time=$2
filename=$1'_Dealer_schedule'

output=$(grep "$time" $filename | cut -d$'\t' -f1,3)
printf "$date\t$output\n"