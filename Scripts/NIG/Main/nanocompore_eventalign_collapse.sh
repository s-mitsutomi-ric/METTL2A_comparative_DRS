#!/bin/bash

today=$(date "+%Y%m%d")
logdir='Log/Nanocompore/Eventalign_collapse/'$today'/'
mkdir -p $logdir

for sample in $(cat nanopore_samples.list ) ; do  

    echo $sample
    err=$logdir$sample'.err'
    out=$logdir$sample'.out'
    qsub -e $err -o $out Scripts/Sub/nanocompore_eventalign_collapse.sh $sample
    sleep 10s
    
done
