#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/fill_gtf_exon_records/'$today'/'
mkdir -p $logdir

err=$logdir'gencode.err'
out=${err/.err/.out}

gtf='Database/gencode.v43.annotation_plus-tRNA.gtf'

qsub -e $err -o $out Scripts/Sub/fill_gtf_exon_records.sh $gtf
