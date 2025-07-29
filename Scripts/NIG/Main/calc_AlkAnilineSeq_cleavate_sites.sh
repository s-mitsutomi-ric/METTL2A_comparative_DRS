#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Cleavage_AAS/'$today'/'
mkdir -p $logdir

for bed in $(ls AlkAniline-seq/STAR/Fastp/*_uniq_sorted_geneinfoplus.bed); do 
    
    echo $bed

    err=$logdir$(basename $bed .bed)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/calc_AlkAnilineSeq_cleavate_sites_in_bed.sh $bed
    sleep 5s

done
