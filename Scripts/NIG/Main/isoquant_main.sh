#!/bin/bash

today=$(date "+%Y%m%d")
logdir="Log/Isoquant/"$today"/"
mkdir -p $logdir

out=$logdir"Isoquant_out.txt"
err=$logdir"Isoquant_err.txt"

qsub -e $err -o $out Scripts/Sub/isoquant.sh 
