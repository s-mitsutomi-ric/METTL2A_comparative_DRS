#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Split_bed/'$today'/'
mkdir -p $logdir

bed='Database/Custom/gencode.v43.plus.tRNA_Espresso.AsPC1/gencode.v43.plus.tRNA_Espresso.AsPC1.bed'
prefix='bed_'
suffix_length=6

err=$logdir'gencode.v43.plus.tRNA_Espresso.AsPC1.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/split_bed_per_gene.sh $bed $prefix $suffix_length
