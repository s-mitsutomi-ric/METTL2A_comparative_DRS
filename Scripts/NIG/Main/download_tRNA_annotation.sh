#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Download/'$today'/'
mkdir -p $logdir

err=$logdir'download_tRNA_annotaiton.err'
out=$logdir'download_tRNA_annotaiton.out'

qsub -e $err -o $out Scripts/Sub/download_tRNA_annotation.sh
