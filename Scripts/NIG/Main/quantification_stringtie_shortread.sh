#!/bin/bash
set -e
set -u 
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Stringtie/Quantification/'$today'/'
mkdir -p $logdir

merged_gtf='Stringtie/Merge_withname/Espresso_AsPC1_shortread_stringtie_merged.gtf'

for bam in $(ls Alignment/STAR/Espresso_AsPC1/*_Aligned.sortedByCoord.out.bam); do 
    
    echo $bam

    basepath=$(basename $bam _Aligned.sortedByCoord.out.bam)

    outdir='Stringtie/Quantification_withname/'$basepath'/'
    mkdir -p $outdir
    outgtf=$outdir$basepath'_stringtie.gtf'

    err=$logdir$basepath'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/quantification_stringtie.sh $bam $merged_gtf $outgtf

    sleep 10s

done
