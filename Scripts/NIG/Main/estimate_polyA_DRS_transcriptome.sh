#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Nanopolish/PolyA/'${today}'/'
mkdir -p $logdir

for sample in $(cat nanopore_samples.list ); do 

    echo $sample

    err=$logdir$sample'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out \
        Scripts/Sub/estimate_polyA_DRS_transcriptome.sh \
        $sample
    
    sleep 5s

done
