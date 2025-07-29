#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/bam2bedGraph/'$today'/'
mkdir -p $logdir

for bam in $(ls Alignment/Minimap2/Spliced/*.bam); do 

    echo $bam
    err=$logdir$(basename $bam .bam)'.err'
    out=$logdir$(basename $bam .bam)'.out'

    qsub -e $err -o $out -v bam=$bam,size=1,normalization=\'CPM\' Scripts/Sub/bam2bedGraph.sh
    sleep 10s

done
