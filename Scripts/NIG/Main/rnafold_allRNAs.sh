#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ViennaRNA/RNAfold/'${today}'/'
mkdir -p $logdir

err=$logdir'allrnas.err'
out=${err/.err/.out}

input='/home/mitsutomi/METTL2A/Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'

qsub -e $err -o $out Scripts/Sub/rnafold.sh $input
