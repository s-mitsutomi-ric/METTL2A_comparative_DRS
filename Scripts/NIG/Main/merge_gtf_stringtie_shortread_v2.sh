#!/bin/bash
set -e
set -u
set -o pipefail

# create gtf list
gtflist='Lists/stringtie_shortread_gtf.list'
ls -1   Stringtie/Reconstruct/*.gtf > $gtflist

# Prepare log file
today=$(date "+%Y%m%d")
logdir='Log/Stringtie/Merge/'$today'/'
mkdir -p $logdir

err=$logdir'shortread.err'
out=${err/.err/.out}

# Ref gtf and merged gtf
refgtf='Database/gencode.v43.annotation.gtf'
mkdir -p 'Stringtie/Merge_withname/'
merged_gtf='Stringtie/Merge_withname/Espresso_AsPC1_shortread_stringtie_merged.gtf'

# Main
qsub -e $err -o $out Scripts/Sub/merge_gtf_stringtie.sh $gtflist $refgtf $merged_gtf

