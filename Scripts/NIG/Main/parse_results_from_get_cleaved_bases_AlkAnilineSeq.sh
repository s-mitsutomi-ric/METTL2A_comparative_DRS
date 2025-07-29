#!/bin/bash
set -e
set -u 
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/parse_get_cleaved_bases/'$today'/'
mkdir -p $logdir

for result in $(ls AlkAniline-seq/STAR/Fastp/*.tsv); do 
    
    echo $result

    err=$logdir$(basename $result .tsv)'.err'
    out=${err/.err/.out}

    outtsv=${result/.tsv/_parsed.tsv}

    qsub -e $err -o $out Scripts/Sub/parse_bed2fastatsv_result.sh $result $outtsv

    sleep 5s

done
