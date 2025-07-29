#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/AGAT/'$today'/'
mkdir -p $logdir

err=$logdir'standardize_espresso_gtf.err'
out=$logdir'standardize_espresso_gtf.out'

gtf='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation.gtf'

qsub -e $err -o $out Scripts/Sub/standardize_gxf.sh $gtf
