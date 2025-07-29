#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/AGAT/'$today'/'
mkdir -p $logdir

# Gencode annotation

gencode_extended='Database/gencode.v43.annotation_plus-tRNA.gff'
gencode_err=$logdir'gff2gtf_gencode.err'
gencode_out=$logdir'gff2gtf_gencode.out'

qsub -e $gencode_err -o $gencode_out Scripts/Sub/gff2gtf.sh $gencode_extended

# Espresso annotation

espresso_standardized='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_standardized.gff'
espresso_err=$logdir'gff2gtf_espresso.err'
espresso_out=$logdir'gff2gtf_espresso.out'

qsub -e $espresso_err -o $espresso_out Scripts/Sub/gff2gtf.sh $espresso_standardized
