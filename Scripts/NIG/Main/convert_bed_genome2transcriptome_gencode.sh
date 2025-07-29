#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/convert_bed_genome2transcriptome/'$today'/'
mkdir -p $logdir

out=$logdir'gencode.v43.out'
err=${out/.out/.err}

input='Database/gencode.v43.annotation_plus-tRNA.bed'
qsub -e $err -o $out Scripts/Sub/convert_bed_genome2transcriptome.sh $input
