#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Fastp/'$today'/'
mkdir -p $logdir

for sample in $(cat Lists/MeRIP-seq_fastq_pair.list ); do 
    
    err=$logdir$(basename $sample)'.err'
    out=${err/.err/.out}

    in1=$sample'_R1_001.fastq.gz'
    in2=$sample'_R2_001.fastq.gz'
    
    outdir='MeRIP-seq/Fastp/'
    mkdir -p $outdir

    prefix=$(echo $sample | sed -e 's/MeRIP-seq\/Fastq\/230222_NovaSeq_SP_TruseqUD_l2_00[0-9]\{2\}_[A-Z][0-9]\{2\}_Dr_Taniue_//g' -e 's/_S[0-9]\{3\}_L002//g')

    outprefix=$outdir$prefix
    qsub -e $err -o $out Scripts/Sub/fastp_PE.sh $in1 $in2 $outprefix

    echo $prefix
    sleep 10s

done
