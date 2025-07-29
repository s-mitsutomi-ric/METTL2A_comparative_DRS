#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir="Log/Samtools-faidx/${today}/"
mkdir -p $logdir

out=$logdir'index_ref_transcripts_from_espresso.out'
err=$logdir'index_ref_transcripts_from_espresso.err'

ref='Espresso/Espresso_Q/sample_info_N2_R0_updated.fasta'

qsub -e $err -o $out Scripts/Sub/samtools_faidx.sh $ref
