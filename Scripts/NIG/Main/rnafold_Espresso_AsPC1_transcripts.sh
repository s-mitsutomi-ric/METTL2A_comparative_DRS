#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/ViennaRNA/RNAfold/'${today}'/'
mkdir -p $logdir

script='Scripts/Sub/rnafold_Espresso_AsPC1_transcript_eachRNA.sh'

for rna in \
$(tail -n+2  Tables/DRS_methylated_positions_relative_range_2024-04-22.tsv \
| cut -f1 | sort -u \
); do 

    err=${logdir}${rna}'.err'
    out=${err/.err/.out}

    qsub -e $err -o $out $script 


    echo $rna

done
