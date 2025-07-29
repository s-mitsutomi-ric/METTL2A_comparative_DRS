#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/merge_gtfs/'$today'/'
mkdir -p $logdir

err=$logdir'merge_espresso_gencode.err'
out=$logdir'merge_espresso_gencode.out'

ref='Database/gencode.v43.annotation_plus-tRNA.gff'
espresso='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_standardized.gff'

outdir='Database/Custom/gencode.v43_Espresso.AsPC1/'
mkdir -p $outdir
outgff=$outdir'gencode.v43_Espresso.AsPC1.gff'

qsub -e $err -o $out Scripts/Sub/merge_gtfs.sh $ref $espresso $outgff
