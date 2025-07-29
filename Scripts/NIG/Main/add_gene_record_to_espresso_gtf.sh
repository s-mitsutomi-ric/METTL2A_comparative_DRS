#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/add_gene_record/'$today'/'
mkdir -p $logdir

err=$logdir'espresso.err'
out=${err/.err/.out}

gtf='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation.gtf'

qsub -e $err -o $out Scripts/Sub/add_gene_record_to_gtf.sh $gtf
