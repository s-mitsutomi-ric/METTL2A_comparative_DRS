#!/bin/bash

for bam in $(ls Alignment/Minimap2/Spliced/*.bam); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/bam2sam/'$today'/'
    mkdir -p $logdir

    basepath=$(basename $bam)
    err=$logdir$basepath'.err'
    out=$logdir$basepath'.out'
    
    qsub -e $err -o $out Scripts/Sub/bam2sam.sh $bam
    sleep 10s

done
