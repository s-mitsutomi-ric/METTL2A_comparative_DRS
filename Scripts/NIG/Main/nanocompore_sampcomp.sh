#!/bin/bash

today=$(date "+%Y%m%d")
logdir='Log/Nanocompore/Sampcomp/'$today'/'
mkdir -p $logdir

for cond in $(echo 'siMETTL2A' 'siMETTL2A_I' 'siMETTL2A_G'); do 
    
    err=$logdir$cond'.err'
    out=$logdir$cond'.out'

    qsub -e $err -o $out Scripts/Sub/nanocompore_sampcomp.sh $cond
    sleep 10s

done
