#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Weblogo/'$today'/'
mkdir -p $logdir

bg_comp='Nanocompore/Espresso/SampComp/siMETTL2A/all_sequences_composition.txt'

outdir='Weblogo/DRS_common_sites/'
mkdir -p $outdir

for fasta in $(ls Fasta/DRS/Kmer_range/*.fasta); do 

    basepath=$(basename $fasta .fasta)
    echo $fasta; 

    err=${logdir}${basepath}'.err'
    out=${err/.err/.out}

    input=${fasta}
    output=${outdir}${basepath}'.eps'

    qsub -e $err -o $out Scripts/Sub/weblogo.sh $input $output $bg_comp

    sleep 5s

done
