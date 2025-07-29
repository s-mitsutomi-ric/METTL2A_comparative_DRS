#!/bin/bash

# for trim-galore -> sortmerna 
for sample in $(cat Lists/Illumina_fastq_pair_basename.list); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/STAR/'$today'/'
    mkdir -p $logdir
    echo $sample

    indir='Sortmerna/'
    outdir='Alignment/STAR/Trim-galore_Sortmerna/'

    err=$logdir$(basename $outdir)'_'$sample'.err'
    out=$logdir$(basename $outdir)'_'$sample'.out'

    qsub -e $err -o $out Scripts/Sub/mapping_with_STAR.sh \
        $sample $indir '_non-rRNA_reads_fwd.fq.gz' '_non-rRNA_reads_rev.fq.gz' \
        $outdir
    sleep 3m

done

# for fastp -> sortmerna
for sample in $(cat Lists/Illumina_fastq_pair_basename.list); do 
    
    today=$(date "+%Y%m%d")
    logdir='Log/STAR/'$today'/'
    mkdir -p $logdir
    echo $sample

    indir='Fastp/'
    outdir='Alignment/STAR/Fastp_Sortmerna/'

    err=$logdir$(basename $outdir)'_'$sample'.err'
    out=$logdir$(basename $outdir)'_'$sample'.out'

    qsub -e $err -o $out Scripts/Sub/mapping_with_STAR.sh \
        $sample $indir '_processed_non-rRNA_reads_fwd.fq.gz' '_processed_non-rRNA_reads_rev.fq.gz' \
        $outdir
    sleep 3m

done
