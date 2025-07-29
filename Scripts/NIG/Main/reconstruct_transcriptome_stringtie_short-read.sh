#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Stringtie/Reconstruct/'$today'/'
mkdir -p $logdir

refgtf='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_geneplus.gtf'

outdir='Stringtie/Reconstruct/'
mkdir -p $outdir

for bam in $(ls Alignment/STAR/Espresso_AsPC1/*_Aligned.sortedByCoord.out.bam); do 
    
    echo $bam

    basepath=$(basename $bam _Aligned.sortedByCoord.out.bam)

    err=${logdir}${basepath}'.err'
    out=${err/.err/.out}

    outgtf=${outdir}${basepath}'.gtf'

    qsub -e $err -o $out Scripts/Sub/reconstruct_transcriptome_stringtie.sh \
        $bam $refgtf $outgtf

    sleep 10s

done
