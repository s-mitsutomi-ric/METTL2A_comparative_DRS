#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ViennaRNA/RNAfold/'${today}'/'
mkdir -p $logdir

err=${logdir}'summarise_m3Crna_rnafold_result.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/summarise_RNAfold_results.sh
