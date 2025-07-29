#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/AGAT/'$today'/'
mkdir -p $logdir

gtf='Database/Custom/gencode.v43.plus.tRNA_Espresso.AsPC1/gencode.v43.plus.tRNA_Espresso.AsPC1.gtf'

err=$logdir'gtf2bed_gencode-v43-tRNA_Espresso.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/gtf2bed.sh $gtf
