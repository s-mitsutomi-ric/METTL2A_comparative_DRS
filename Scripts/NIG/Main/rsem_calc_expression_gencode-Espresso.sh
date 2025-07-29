#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Rsem/Calc_expression/'$today'/'
mkdir -p $logdir

index='Database/Custom/gencode.v43_Espresso.AsPC1/RSEM_index'

outdir='HAC-seq/RSEM/Fastp/'
mkdir -p $outdir

strand='forward'

for bam in $(ls HAC-seq/STAR/Fastp/*_processed_Aligned.toTranscriptome.out.bam); do 
    
    echo $bam

    prefix=$outdir$(basename $bam .toTranscriptome.out.bam)

    err=$logdir$(basename $bam .toTranscriptome.out.bam)'.err'
    out=$logdir$(basename $bam .toTranscriptome.out.bam)'.out'
    
    qsub -v bam=$bam,index=$index,prefix=$prefix,strand=$strand -e $err -o $out \
        Scripts/Sub/rsem_calculate_expression_bam_SE.sh

    sleep 10s

done
