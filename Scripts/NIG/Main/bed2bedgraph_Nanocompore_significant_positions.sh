#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/bed2bedgraph/'$today'/'
mkdir -p $logdir

genome='Database/gencode.v43.annotation_plus-tRNA_CDS_transcriptome.genome'

for bed in $(ls Nanocompore/Espresso/SampComp/*/*.bed); do 
    
    echo $bed

    err=$logdir$(basename $bed .bed)'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out Scripts/Sub/bed2bedgraph.sh $bed $genome
    sleep 10s

done
