#!/bin/bash

for sample in $(cat nanopore_samples.list ); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/Nanopolish/'$today'/'
    mkdir -p $logdir

    out=$logdir$sample'_nanopolish_index.out'
    err=$logdir$sample'_nanopolish_index.err'

    qsub -e $err -o $out Scripts/Sub/nanopolish_index.sh $sample 
    sleep 20s

done
