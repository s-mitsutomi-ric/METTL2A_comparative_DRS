#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Bedtools/'$today'/Sort/'
mkdir -p $logdir

for bed in $(ls AlkAniline-seq/STAR/Fastp/*_cleavage.bed); do 

    err=$logdir$(basename $bed .bed)'.err'
    out=${err/.err/.out}
    
    qsub -e $err -o $out Scripts/Sub/sort_bed.sh $bed

    echo $bed
    sleep 5s

done
