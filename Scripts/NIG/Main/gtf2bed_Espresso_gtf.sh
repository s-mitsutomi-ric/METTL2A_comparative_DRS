#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/gtf2bed/'$today'/'
mkdir -p $logdir

out=$logdir'Espresso_AsPC1.out'
err=$logdir'Espresso_AsPC1.err'

gtf='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation.gtf'

qsub -e $err -o $out Scripts/Sub/gtf2bed.sh $gtf
