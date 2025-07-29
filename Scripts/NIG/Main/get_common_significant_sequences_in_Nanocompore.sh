#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/Get_common_seqs/'$today'/'
mkdir -p $logdir

for test in GMM KS dwell intensity ; do 
    
    echo $test

    err=$logdir$test'.err'
    out=$logdir$test'.out'

    qsub -e $err -o $out Scripts/Sub/get_common_significant_sequences_in_Nanocompore.sh $test
    sleep 10s

done
