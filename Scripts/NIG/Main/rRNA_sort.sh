#!/bin/bash

for sample in $(cat Lists/Illumina_fastq_pair_basename.list); do 
    
    indir='Fastp/'

    today=$(date "+%Y%m%d")
    logdir='Log/Sortmerna/'$today'/'
    mkdir -p $logdir

    err=$logdir$sample'.err'
    out=$logdir$sample'.out'
    
    echo $sample 
    qsub -e $err -o $out Scripts/Sub/rRNA_sort_sortmerna.sh $indir$sample
    sleep 10s
    
done
