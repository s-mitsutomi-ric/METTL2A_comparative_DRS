#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/bam2bdg/'$today'/'
mkdir -p $logdir

for bam in $(ls Alignment/STAR/Espresso_AsPC1/*_Aligned.sortedByCoord.out.bam); do 

    echo $bam
    err=$logdir$(basename $bam .bam)'.err'
    out=$logdir$(basename $bam .bam)'.out'

    qsub -e $err -o $out Scripts/Sub/bam2bdg_CPM_size1.sh $bam
    sleep 5s

done
