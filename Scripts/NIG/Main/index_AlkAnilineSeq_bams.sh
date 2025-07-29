#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Index_bam/'$today'/'
mkdir -p $logdir

for bam in $(ls AlkAniline-seq/STAR/Fastp/*_uniq.bam); do 

    echo $bam

    err=$logdir$(basename $bam .bam)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/index_bam.sh $bam
    sleep 5s

done

for bam in $(ls AlkAniline-seq/STAR/Fastp/*.toTranscriptome.out.bam); do 

    echo $bam

    err=$logdir$(basename $bam .bam)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/index_bam.sh $bam
    sleep 5s

done
