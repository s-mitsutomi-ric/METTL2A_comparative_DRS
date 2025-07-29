#!/bin/bash

# Make directory for log files
today=$(date "+%Y%m%d")
logdir="Log/Minimap2/"$today"_spliced/"
mkdir -p $logdir

# Loop samples
for sample in $(cat nanopore_samples.list); do 
    
    echo $sample
    log_e=$logdir$sample"_err.txt"
    log_o=$logdir$sample"_out.txt"

    qsub -e $log_e -o $log_o Scripts/Sub/align_minimap2_spliced.sh $sample

    sleep 1m 

done
