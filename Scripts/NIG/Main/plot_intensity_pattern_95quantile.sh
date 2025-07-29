#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Plot_int_dist/'$today'/'
mkdir -p $logdir

tsv='Nanocompore/Espresso/Methylated_sites/common_sig_positions_in_intensity.tsv'

for trid in $(cut -d '|' -f1 $tsv | sort -u); do 

    echo $trid

    err=$logdir$trid'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/plot_intensity_95quantile.sh $trid
    sleep 10s

done
