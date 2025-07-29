#!/bin/bash

input=$1
prefix=$2

outdir='Tables/Nanocompore/Signal_parameters/'
mkdir -p $outdir

today=$(date "+%Y%m%d")
logdir='Log/Others/filter_read_pars/'$today'/'
mkdir -p $logdir

sig_pos_tsv='Nanocompore/Espresso/Methylated_sites/common_sig_positions_in_intensity.tsv'

for transcript in $(awk -v FS="|" '{print $1}' $sig_pos_tsv | sort -u); do 

    err=$logdir$prefix$transcript'.err'

    shscript='Scripts/Sub/filter_read_parameter_each_transcript.sh'
    outtsv=$outdir$prefix$transcript'.tsv'

    qsub -e $err $shscript $input $transcript $outtsv
    sleep 20s

done
