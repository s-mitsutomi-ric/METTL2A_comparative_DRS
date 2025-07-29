#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/gtf2table/'$today'/'
mkdir -p $logdir

# gencode plus tRNA

gtf='Database/gencode.v43.annotation_plus-tRNA.gtf'
err=$logdir'gencode_plus_tRNA.err'
out=$logdir'gencode_plus_tRNA.out'

qsub -e $err -o $out Scripts/Sub/gtf2table.sh $gtf

# Espresso (AsPC-1)

gtf='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_standardized.gtf'
err=$logdir'espresso_AsPC1.err'
out=$logdir'espresso_AsPC1.out'

qsub -e $err -o $out Scripts/Sub/gtf2table.sh $gtf

# Espresso (AsPC-1) + gencode

gtf='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gtf'
err=$logdir'gencode_espresso.err'
out=$logdir'gencode_espresso.out'

qsub -e $err -o $out Scripts/Sub/gtf2table.sh $gtf
