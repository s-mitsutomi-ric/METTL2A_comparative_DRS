#!/bin/bash
set -e
set -u
set -o pipefail

outdir='Seqkit/Count_reads_mapped2refs/Espresso_unspliced/'
mkdir -p $outdir

logdir='Log/Seqkit/Count_reads_mapped2refs/'
mkdir -p $logdir

for bam in $(ls Alignment/Minimap2/Espresso_unspliced/*.bam); do 

    echo $bam
    script_path='Scripts/Sub/count_reads_mapped2chromosomes.sh'

    out=$logdir$(basename $bam .bam)'.out'
    err=$logdir$(basename $bam .bam)'.err'
    
    qsub -e $err -o $out $script_path $bam $outdir
    sleep 10s

done
