#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir="Log/Samtools-faidx/${today}/"
mkdir -p $logdir

out=$logdir'index_transcriptome_fasta_espresso.out'
err=${out/.out/.err}

ref='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'

qsub -e $err -o $out Scripts/Sub/samtools_faidx.sh $ref
