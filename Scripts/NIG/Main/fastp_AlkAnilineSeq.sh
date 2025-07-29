#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Fastp/'$today'/'
mkdir -p $logdir

for fastq in $(ls AlkAniline-seq/Fastq/*.fastq.gz); do

    echo $fastq
    outdir='AlkAniline-seq/Fastp/'
    basepath=$(basename $fastq)

    err=$logdir$basepath'.err'
    out=$logdir$basepath'.out'

    qsub -e $err -o $out Scripts/Sub/fastp_single.sh $fastq $outdir
    sleep 5s

done
