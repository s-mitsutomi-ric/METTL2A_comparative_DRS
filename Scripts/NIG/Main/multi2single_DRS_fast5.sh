#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ONT-fast5-api/Multi2single/'$today'/'
mkdir -p $logdir

for sample in $(cat nanopore_samples.list ); do 

    echo $sample

    err=${logdir}${sample}'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/multi2single_fast5.sh $sample
    sleep 5s

done
