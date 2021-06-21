#!/bin/bash
name=$2
filename=$1'_win_loss_player_data'
grep $name $filename | wc -l