#!/bin/bash
set -e
set -u
set -o pipefail

transcript_id='ENST00000361390.2'
outdir='Tables/Nanocompore/Signal_parameters/'

today=$(date "+%Y%m%d")
logdir='Log/Others/signal_parameters_nanocompore/'$today'/'
mkdir -p $logdir

err=$logdir'test.err'
out=${err/.err/.out}

qsub_beta -e $err -o $out Scripts/Sub/get_signal_parameters_4_each_position.sh \
    $transcript_id $outdir
