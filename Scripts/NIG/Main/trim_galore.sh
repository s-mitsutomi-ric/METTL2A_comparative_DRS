#!/bin/bash

for sample in $(cat Lists/Illumina_fastq_pair.list); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/Trim_galore/'$today'/'
    mkdir -p $logdir

    err=$logdir$(basename $sample)'.err';
    out=$logdir$(basename $sample)'.out';
    
    echo $sample; 
    qsub -e $err -o $out Scripts/Sub/trim_galore.sh $sample;
    sleep 1m;
done
