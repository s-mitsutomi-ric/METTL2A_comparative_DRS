#!/bin/bash
set -e
set -u
set -o pipefail 

today=$(date "+%Y%m%d")
logdir='Log/Fastqc/'$today'/'
mkdir -p $logdir

outdir='AlkAniline-seq/Fastqc/Fastq/'
mkdir -p $outdir

for fastq in $(ls AlkAniline-seq/Fastq/*.fastq.gz); do
    
    echo $fastq

    err=$logdir$(basename $fastq)'.err'
    out=$logdir$(basename $fastq)'.out'

    qsub -e $err -o $out -v outdir=$outdir Scripts/Sub/fastqc.sh $fastq
    sleep 5s

done
