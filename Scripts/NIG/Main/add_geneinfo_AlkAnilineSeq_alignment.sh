#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Bedtools/'$today'/'
mkdir -p $logdir

refbed='Database/gencode.v43.annotation_plus-tRNA_exon-complemented.bed'

for bed in $(ls AlkAniline-seq/STAR/Fastp/*_Aligned.sortedByCoord.out_uniq_sorted.bed); do 

    echo $bed

    err=$logdir$(basename $bed .bed)'_add_geneinfo.err'
    out=${err/.err/.out}

    outbed=${bed/.bed/_geneinfoplus.bed}
    fraction='-f 0.5'

    qsub -e $err -o $out \
        -v input=$bed,output=$outbed,ref=$refbed,fraction="$fraction" \
        Scripts/Sub/add_geneinfo_alignment.sh 

    sleep 5s

done
