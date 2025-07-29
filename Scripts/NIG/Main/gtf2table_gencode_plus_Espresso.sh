#!/bin/bash
set -e
set -u
set -o pipefail

gtf='Database/Custom/gencode.v43.plus.tRNA_Espresso.AsPC1/gencode.v43.plus.tRNA_Espresso.AsPC1.gtf'

today=$(date "+%Y%m%d")
logdir='Log/Others/gtf2table/'$today'/'
mkdir -p $logdir
    
err=$logdir$(basename $gtf .gtf)'.err'    
out=$logdir$(basename $gtf .gtf)'.out'

qsub -e $err -o $out Scripts/Sub/gtf2table.sh $gtf
