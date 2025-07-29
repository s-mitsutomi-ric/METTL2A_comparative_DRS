#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Bedtools/'$today'/'
mkdir -p $logdir

genome='Database/GRCh38.p13.genome.fa'

for bed in $(ls AlkAniline-seq/STAR/Fastp/*_geneinfoplus_cleavage_sorted.bed); do 
    
    echo $bed

    err=$logdir'get_cleaved_seq_'$(basename $bed .bed)'.err'
    out=${err/.err/.out}

    tsv=${bed/.bed/_bases.tsv}

    qsub -e $err -o $out Scripts/Sub/bed2fastatsv.sh $bed $genome $tsv

    sleep 5s

done
