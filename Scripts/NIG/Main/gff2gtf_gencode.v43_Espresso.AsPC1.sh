#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/AGAT/'$today'/'
mkdir -p $logdir

# Gencode annotation

gff='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gff'
err=$logdir'gff2gtf_gencode_Espresso.err'
out=$logdir'gff2gtf_gencode_Espresso.out'

qsub -e $err -o $out Scripts/Sub/gff2gtf.sh $gff
