#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/gtf2bed/'$today'/'
mkdir -p $logdir

out=$logdir'gencode-v43-plus-tRNA_exon-complemented.out'
err=${out/.out/.err}

gtf='Database/gencode.v43.annotation_plus-tRNA_exon-complemented.gtf'

qsub -e $err -o $out Scripts/Sub/gtf2bed.sh $gtf
