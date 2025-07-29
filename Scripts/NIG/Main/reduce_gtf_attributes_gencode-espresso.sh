#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/reduce_gtf_attributes/'$today'/'
mkdir -p $logdir

gtf='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gtf'

err=$logdir$(basename $gtf .gtf)'.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/reduce_gtf_attributes.sh $gtf
