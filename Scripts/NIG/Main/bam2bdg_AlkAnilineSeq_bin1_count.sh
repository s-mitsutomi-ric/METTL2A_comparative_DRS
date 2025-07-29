#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/bam2bdg/'$today'/'
mkdir -p $logdir

for bam in $(ls AlkAniline-seq/STAR/Fastp/*Aligned.sortedByCoord.out_uniq_sorted.bam); do 
    
    echo $bam

    err=$logdir'bin1_count_'$(basename $bam .bam)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/bam2bdg_bin1_count.sh $bam
    sleep 5s

done
