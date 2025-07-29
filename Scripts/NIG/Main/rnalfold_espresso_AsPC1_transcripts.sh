#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ViennaRNA/RNALfold/'${today}'/'
mkdir -p $logdir

err=$logdir'espresso_AsPC1_transcripts.err'
out=${err/.err/.out}

input='/home/mitsutomi/METTL2A/Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'
outdir='RNALfold/'

qsub -e $err -o $out Scripts/Sub/rnalfold.sh $input $outdir
