#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/merge2gtf2gtf/'$today'/'
mkdir -p $logdir

err=$logdir'espresso_gencode.err'
out=${err/.err/.out}

ref='Database/gencode.v43.annotation_plus-tRNA_exon-complemented.gtf'
add='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_geneplus.gtf'

outdir='Database/Custom/gencode.v43.plus.tRNA_Espresso.AsPC1/'
mkdir -p $outdir

output=$outdir'gencode.v43.plus.tRNA_Espresso.AsPC1.gtf'

qsub -e $err -o $out Scripts/Sub/merge_two_gtfs.sh \
    $ref $add $output
