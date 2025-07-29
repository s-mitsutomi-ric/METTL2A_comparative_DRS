#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Slow5tools/'
mkdir -p $logdir

for sample in $(cat Lists/longread_samples.list ); do 
    
    echo $sample

    fast5dir='Rawdata/Nanopore_directRNAseq/'$sample'/fast5_pass/'
    outdir='Slow5/dRNA-seq/'$sample'/'
    mkdir -p $outdir

    err=$logdir$sample'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/fast5toslow5.sh $fast5dir $outdir

    sleep 10s

done
