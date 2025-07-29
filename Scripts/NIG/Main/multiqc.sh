#!/bin/bash

dir=$1

today=$(date "+%Y%m%d")
logdir='Log/Multiqc/'$today'/'
out=$logdir'multiqc_'$(basename $dir)'.out'
err=$logdir'multiqc_'$(basename $dir)'.err'

qsub -e $err -o $out Scripts/Sub/multiqc.sh $dir 
