#!/bin/bash

for sample in $(cat Lists/Illumina_fastq_pair.list); do 
    
    sample_basename=$(basename $sample)

    today=$(date "+%Y%m%d")
    logdir='Log/Sortmerna/'$today'/'
    mkdir -p $logdir

    err=$logdir$(basename $sample)'.err';
    out=$logdir$(basename $sample)'.out';
    
    echo $sample; 
    qsub -e $err -o $out Scripts/Sub/sortmerna.sh $sample_basename;
    sleep 1m;
    
done
