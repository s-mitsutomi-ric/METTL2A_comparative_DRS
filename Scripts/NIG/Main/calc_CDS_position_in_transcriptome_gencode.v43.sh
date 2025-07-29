#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Calc_CDS_position/'$today'/'
mkdir -p $logdir

out=$logdir'gencode-v43.out'
err=${out/.out/.err}

qsub -e $err -o $out Scripts/Sub/calc_feature_position_in_transcriptome.sh
