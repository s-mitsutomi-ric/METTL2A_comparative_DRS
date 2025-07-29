#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Compress_bg_4_dRNA-seq/'$today'/'
mkdir -p $logdir

for bg in $(ls Alignment/Minimap2/Spliced/*.bedGraph); do 

    echo $bg

    err=$logdir$(basename $bg .bedGraph)'.err'
    out=$logdir$(basename $bg .bedGraph)'.out'

    qsub -e $err -o $out Scripts/Sub/compress_bg_4_SparK.sh $bg
    sleep 10s

done
