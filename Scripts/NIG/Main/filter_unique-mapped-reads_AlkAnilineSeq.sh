#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Samtools/'$today'/'
mkdir -p $logdir

for bam in $(ls AlkAniline-seq/STAR/Fastp/*.bam); do 
    
    echo $bam

    err=$logdir'filter_unique-mapped-reads_AAS_'$(basename $bam .bam)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/filter_unique-mapped-reads_bam.sh $bam
    sleep 5s

done
