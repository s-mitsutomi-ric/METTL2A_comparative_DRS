#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/FeatureCounts/'$today'/'
mkdir -p $logdir

err=$logdir'AlkAniline-seq_Fastp.err'
out=$logdir'AlkAniline-seq_Fastp.out'

qsub -e $err -o $out Scripts/Sub/featureCounts_AlkAnilineSeq_gene.sh
