#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/FeatureCounts/'$today'/'
mkdir -p $logdir

err=$logdir'short-reads_Espresso.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/featureCounts_short-reads_gene.sh
