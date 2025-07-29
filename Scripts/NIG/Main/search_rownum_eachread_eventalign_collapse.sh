#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Other/search_rownum_eachread_eventalign_collapse/'$today'/'
mkdir -p $logdir

for sample in $(cat Lists/longread_samples.list); do 
    
    echo $sample

    err=$logdir$sample'.err'
    out=${err/.err/.out} 

    tsv='Nanocompore/Espresso/Eventalign_collapse/'$sample'/out_eventalign_collapse.tsv'
    script='Scripts/Sub/search_rownum_eachread_eventalign_collapse.sh'
    
    qsub -e $err -o $out $script $tsv
    sleep 10s

done
