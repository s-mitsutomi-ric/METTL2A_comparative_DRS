#!/bin/bash
set -e
set -u
set -o pipefail

for sample in $(cat nanopore_samples.list); do 

    logdir='Log/Concatenate_fastq/'
    mkdir -p $logdir
    out=$logdir$sample'.out'
    err=$logdir$sample'.err'

    qsub -e $err -o $out Scripts/Sub/concatenate_longread_fastq.sh $sample
    sleep 10s

done
