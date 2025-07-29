#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Weblogo/'$today'/'
mkdir -p $logdir

bg_comp='Nanocompore/Espresso/SampComp/siMETTL2A/all_sequences_composition.txt'

for test in KS GMM dwell intensity; do

    echo $test
        
    err=$logdir$test'.err'
    out=$logdir$test'.out'

    input='Nanocompore/Espresso/Methylated_sites/common_sig_positions_in_'$test'.fasta'
    outdir='Weblogo/dRNA-seq_Nanocompore/'
    mkdir -p $outdir

    output=$outdir'commonly-significant-in-'$test'.eps'

    qsub -e $err -o $out Scripts/Sub/weblogo.sh $input $output $bg_comp

    sleep 10s

done
