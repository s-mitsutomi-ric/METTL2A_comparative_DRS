#!/bin/bash

for sample in $(cat Lists/Illumina_fastq_pair.list); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/Fastp/'$today'/'
    mkdir -p $logdir

    err=$logdir$(basename $sample)'.err';
    out=$logdir$(basename $sample)'.out';
    
    echo $sample; 
    qsub -e $err -o $out Scripts/Sub/fastp.sh $sample;
    sleep 10s;
done
