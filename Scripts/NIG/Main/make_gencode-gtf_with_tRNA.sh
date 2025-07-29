#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/AGAT/'$today'/'
mkdir -p $logdir

out=$logdir'make_gencode-gtf_with_tRNA.out'
err=$logdir'make_gencode-gtf_with_tRNA.err'

input='Database/gencode.v43.annotation.gtf'
tRNA='Database/gencode.v43.tRNAs.gtf'
new='Database/gencode.v43.annotation_plus-tRNA.gff'

qsub -e $err -o $out Scripts/Sub/merge_gtfs.sh $input $tRNA $new
