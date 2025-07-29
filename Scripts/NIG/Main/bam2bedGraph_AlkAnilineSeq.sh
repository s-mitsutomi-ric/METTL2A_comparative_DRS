#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/bam2bedGraph/'$today'/'
mkdir -p $logdir

for bambai in $(ls AlkAniline-seq/STAR/Fastp/*.bam.bai); do 

    bam=${bambai/.bai/}
    echo $bam
    err=$logdir$(basename $bam .bam)'.err'
    out=$logdir$(basename $bam .bam)'.out'

    qsub -e $err -o $out -v bam=$bam,size=1,normalization=\'CPM\' Scripts/Sub/bam2bdg.sh
    sleep 5s

done
