#!/bin/bash
set -e
set -u
set -o pipefail
    
today=$(date "+%Y%m%d")
logdir='Log/STAR/Mapping/'$today'/'
mkdir -p $logdir

indir='Fastp/'
outdir='Alignment/STAR/Espresso_AsPC1/'
mkdir -p $outdir

index='Database/Custom/Espresso_AsPC1/STAR_index/'

for sample in $(cat Lists/Illumina_fastq_pair_basename.list); do 

    echo $sample

    err=$logdir$sample'.err'
    out=$logdir$sample'.out'

    prefix=$outdir$sample'_'

    read1=$indir$sample'_R1_001_processed.fastq.gz'
    read2=$indir$sample'_R2_001_processed.fastq.gz'

    qsub -v index=$index,outprefix=$prefix \
        -e $err -o $out Scripts/Sub/mapping_with_STAR_PE.sh $read1 $read2
    sleep 10s

done
