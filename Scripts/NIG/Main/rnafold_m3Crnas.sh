#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ViennaRNA/RNAfold/'${today}'/'
mkdir -p $logdir

err=$logdir'm3crnas.err'
out=${err/.err/.out}

input='/home/mitsutomi/METTL2A/Tables/m3C_RNAs_seqs.fasta'

qsub -e $err -o $out Scripts/Sub/rnafold_m3Crnas.sh $input
