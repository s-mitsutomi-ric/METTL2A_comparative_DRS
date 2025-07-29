#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Seqkit/fasta2tsv/'$today'/'
mkdir -p $logdir

err=$logdir'espresso_AsPC1_transcripts.err'
out=${err/.err/.out}

fasta='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'
tsv=${fasta/.fasta/.tsv}

qsub -e $err -o $out Scripts/Sub/fx2tab_seqlength.sh $fasta $tsv
