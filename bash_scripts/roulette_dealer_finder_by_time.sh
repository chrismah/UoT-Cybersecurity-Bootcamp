#!/bin/bash
date=$1
time=$2
filename=$1'_Dealer_schedule'

grep "$time" $filename | cut -d$'\t' -f3