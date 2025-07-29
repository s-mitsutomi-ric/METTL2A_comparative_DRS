#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Count_reads/'${today}'/'
mkdir -p $logdir

err=${logdir}'count_reads.err'
out=${err/.err/.out}

dir='Alignment/Minimap2/Spliced'
outdir='Tables/DRS/Num_reads_mapped/'
mkdir -p $outdir
outtsv=${outdir}'chrM_nonchrM.tsv'

qsub -e $err -o $out Scripts/Sub/count_chrM_nonchrM_reads_fromSAM.sh \
    $dir $outtsv
