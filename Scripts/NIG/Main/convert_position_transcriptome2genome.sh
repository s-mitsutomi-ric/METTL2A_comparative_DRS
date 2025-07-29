#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Others/transcriptome2genome/'$today'/'
mkdir -p $logdir

ref_bed='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation.bed'

outdir='Nanocompore/Espresso/Methylated_sites/'
mkdir -p $outdir

for bed in $(ls Nanocompore/Espresso/SampComp/*/sig_positions_in_*.tsv ); do 

    echo $bed

    err=$logdir$(basename $bed .tsv)'.err'
    out=$logdir$(basename $bed .tsv)'.out'    

    temp=$(echo $bed | sed 's/\/sig_positions/_sig_positions/g')
    output=$outdir$(basename $temp .tsv)'.bed'

    qsub -e $err -o $out Scripts/Sub/convert_position_transcriptome2genome.sh $bed $ref_bed $output
    sleep 10s

done
