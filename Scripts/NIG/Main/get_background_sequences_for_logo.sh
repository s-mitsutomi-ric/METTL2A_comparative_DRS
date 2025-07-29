#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/get_bg_sequences/'
mkdir -p $logdir

for sample in siMETTL2A siMETTL2A_I siMETTL2A_G; do

    echo $sample

    err=$logdir'get_bg_seqs.err'
    out=$logdir'get_bg_seqs.out'

    qsub -e $err -o $out Scripts/Sub/get_background_sequences_for_logo.sh $sample

done
