#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Tombo/Resquiggle/'$today'/'
mkdir -p $logdir

subscript='Scripts/Sub/tombo_resquiggle_rna.sh'

for sample in $(cat nanopore_samples.list); do 

    err=${logdir}${sample}'.err'
    out=${err/.err/.out}

    echo $sample
    qsub -e $err -o $out $subscript $sample
    sleep 5s

done
