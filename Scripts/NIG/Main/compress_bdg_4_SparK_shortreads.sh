#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Compress_bdg/Short-reads/'$today'/'
mkdir -p $logdir

for bg in $(ls Alignment/STAR/Espresso_AsPC1/*.bdg); do 

    echo $bg

    err=$logdir$(basename $bg .bdg)'.err'
    out=$logdir$(basename $bg .bdg)'.out'

    qsub -e $err -o $out Scripts/Sub/compress_bg_4_SparK.sh $bg
    sleep 10s

done
