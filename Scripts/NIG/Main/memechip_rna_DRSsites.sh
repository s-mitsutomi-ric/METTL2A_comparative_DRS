#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Memechip/MEME-ChIP/'$today'/'
mkdir -p $logdir

result_basedir='MEME-ChIP/'
mkdir -p $result_basedir

background_fasta='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts_markovbg_order_2.txt'

for fasta in $(ls Nanocompore/Espresso/Methylated_sites/common_sig_positions_in_intensity*_neibor*.fasta); do 

    echo $fasta

    fasta_base=$(basename $fasta .fasta)

    err=${logdir}${fasta_base}'.err'
    out=${err/.err/.out}

    result_dir=${result_basedir}${fasta_base}'/'

    qsub -e $err -o $out Scripts/Sub/memechip_rna.sh \
        $fasta $result_dir ${background_fasta}

    sleep 5s

done
