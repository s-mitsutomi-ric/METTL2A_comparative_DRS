#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Filter_nanocompore_sequences/'$today'/'
mkdir -p $logdir

for sample in siMETTL2A siMETTL2A_G siMETTL2A_I; do 

    echo $sample

    input='Nanocompore/Espresso/SampComp/'$sample'/outnanocompore_results.tsv'
    err=$logdir$sample'.err'
    out=$logdir$sample'.out'

    qsub -e $err -o $out Scripts/Sub/filter_significant_sequences_in_Nanocompore.sh $input
    sleep 10s

done
