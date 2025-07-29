#!/bin/bash
set -u
set -e
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/gtf2fasta/'$today'/'
mkdir -p $logdir

err=$logdir'espresso_gtf.err'
out=$logdir'espresso_gtf.out'

gtf='Espresso/Espresso_Q/sample_info_N2_R0_updated.gtf'

qsub -e $err -o $out Scripts/Sub/gtf2transcriptFasta.sh $gtf
