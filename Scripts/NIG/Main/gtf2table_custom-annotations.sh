#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/gtf2table/'$today'/'
mkdir -p $logdir

for gtf in $(ls Database/Custom/*/*.gtf); do 
    
    echo $gtf

    err=$logdir$(basename $gtf .gtf)'.err'
    out=$logdir$(basename $gtf .gtf)'.out'

    qsub -e $err -o $out Scripts/Sub/gtf2table.sh $gtf
    sleep 10s

done
