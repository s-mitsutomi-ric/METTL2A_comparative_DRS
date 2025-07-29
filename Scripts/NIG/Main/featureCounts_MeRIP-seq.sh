#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/FeatureCounts/'$today'/'
mkdir -p $logdir

err=$logdir'MeRIP-seq.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/featureCounts_MeRIP-seq_gene.sh
