#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/merge_gtfs/'$today'/'
mkdir -p $logdir

err=$logdir'Merge_espresso_gencode_with-tRNA.err'
out=$logdir'Merge_espresso_gencode_with-tRNA.out'

qsub -e $err -o $out Scripts/Sub/merge_espresso_gencode_gtfs_withtRNA.sh
