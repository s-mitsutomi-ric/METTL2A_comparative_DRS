#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Picard/CreateSequenceDictionary/'${today}'/'
mkdir -p $logdir

err=${logdir}'AsPC1_transcriptome.err'
out=${err/.err/.out}

ref='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'

qsub -e $err -o $out Scripts/Sub/picard_CreateSequenceDictionary.sh $ref
