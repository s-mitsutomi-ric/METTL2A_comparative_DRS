#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Bedtools/'$today'/'
mkdir -p $logdir

for bam in $(ls AlkAniline-seq/STAR/Fastp/*_uniq_sorted.bam); do 

    echo $bam

    err=$logdir'bam2bed12_'$(basename $bam .bam)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/bam2bed12.sh $bam

    sleep 5s

done
