#!/bin/bash
set -e
set -u
set -o pipefail

for sample in $(cat nanopore_samples.list); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/Nanocompore/'$today'/'
    mkdir -p $logdir

    out=$logdir$sample'_eventalign.out'
    err=$logdir$sample'_eventalign.err'

    qsub_beta -e $err -o $out Scripts/Sub/nanopolish_eventalign_espresso.sh $sample 
    sleep 10s

done
