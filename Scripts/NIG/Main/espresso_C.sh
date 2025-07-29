#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Espresso/C/'$today'/'
mkdir -p $logdir

for id in $(awk '{print $3}' Espresso/sample_info.tsv.updated); do 

    err=$logdir$id'.err'
    out=$logdir$id'.out'

    qsub -e $err -o $out Scripts/Sub/espresso_C.sh $id
    sleep 10s
    
done
