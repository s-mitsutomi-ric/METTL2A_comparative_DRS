#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ViennaRNA/RNALfold/'${today}'/'
mkdir -p $logdir

err=$logdir'summary.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/summarise_RNALfold_results.sh
