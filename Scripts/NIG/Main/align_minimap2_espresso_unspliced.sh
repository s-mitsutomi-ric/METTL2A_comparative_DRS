#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Minimap2/'$today'_unspliced/'
mkdir -p $logdir

transcriptome_fasta='Espresso/Espresso_Q/sample_info_N2_R0_updated.fasta'
outdir='Alignment/Minimap2/Espresso_Unspliced/'

for sample in $(cat nanopore_samples.list); do 
    
    echo $sample

    err=$logdir$sample'.err'
    out=$logdir$sample'.out'

    qsub -e $err -o $out Scripts/Sub/minimap2_unspliced.sh $sample $transcriptome_fasta $outdir
    sleep 30s

done
