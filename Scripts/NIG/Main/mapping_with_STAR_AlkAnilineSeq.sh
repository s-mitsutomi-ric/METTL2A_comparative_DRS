#!/bin/bash
set -e 
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/STAR/Mapping/'$today'/'
mkdir -p $logdir

index='Database/Custom/gencode.v43_Espresso.AsPC1/STAR_index/'

outdir='AlkAniline-seq/STAR/Fastp/'
mkdir -p $outdir

for fastq in $(ls AlkAniline-seq/Fastp/*_processed.fastq.gz); do 
    
    echo $fastq

    out=$logdir$(basename $fastq .fastq.gz)'_fastp.out'
    err=$logdir$(basename $fastq .fastq.gz)'_fastp.err'

    qsub -e $err -o $out \
        -v read=$fastq,outdir=$outdir,index=$index \
        Scripts/Sub/mapping_with_STAR_SE.sh 
    sleep 5s

done
