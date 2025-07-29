#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Espresso/Q/'$today'/'

mkdir -p $logdir

err=$logdir'espresso_Q.err'
out=$logdir'espresso_Q.out'

qsub -e $err -o $out Scripts/Sub/espresso_Q.sh
