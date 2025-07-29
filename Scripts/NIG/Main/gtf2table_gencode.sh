#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/gtf2table/'$today'/'
mkdir -p $logdir

err=$logdir'gencode.v43.err'
out=$logdir'gencode.v43.out'

gtf='Database/gencode.v43.annotation.gtf'

qsub -e $err -o $out Scripts/Sub/gtf2table.sh $gtf
