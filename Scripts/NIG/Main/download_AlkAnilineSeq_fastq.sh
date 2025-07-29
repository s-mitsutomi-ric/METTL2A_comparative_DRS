#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Download/'$today'/'
mkdir -p $logdir

for id in $(awk '$6 ~ "ERR" {print $6}' Tables/AlkAnilineSeq_ENA_info.txt); do 

    err=$logdir$id'.err'
    out=${err/.err/.out}

    dstdir='AlkAniline-seq/Fastq/'

    qsub -e $err -o $out Scripts/Sub/download_ENA_fastq.sh $id $dstdir
    echo $id
    sleep 10s

done
