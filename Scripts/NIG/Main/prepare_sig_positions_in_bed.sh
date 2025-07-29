#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Prepare_sig_positions_in_bed/'$today'/'
mkdir -p $logdir

for tsv in $(ls Nanocompore/Espresso/SampComp/siMETTL2A*/sig_sequences_in_*.tsv); do

    echo $tsv

    err=$logdir$(basename $tsv .tsv)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/prepare_sig_positions_in_bed.sh $tsv
    sleep 10s

done
