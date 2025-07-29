#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Weblogo/'$today'/'
mkdir -p $logdir

for sample in siMETTL2A siMETTL2A_I siMETTL2A_G; do

    echo $sample

    bg='Nanocompore/Espresso/SampComp/'$sample'/all_sequences.fasta'
    bg_count=${bg/.fasta/_ACGT.txt}

    bash Scripts/Sub/count_ACGT.sh $bg > $bg_count 

    bg_comp=${bg/.fasta/_composition.txt}
    R='/usr/local/biotools/r/r-base:4.2.1'
    scriptpath='Scripts/Sub/format_ACGT_composition4weblogo.R'
    singularity exec $R Rscript $scriptpath -i $bg_count -d 0 > $bg_comp

    for test in KS GMM dwell intensity; do

        echo $test
        
        err=$logdir$sample'_'$test'.err'
        out=$logdir$sample'_'$test'.out'

        input='Nanocompore/Espresso/SampComp/'$sample'/sig_sequences_in_'$test'.fasta'
        outdir='Weblogo/dRNA-seq_Nanocompore/'
        mkdir -p $outdir

        output=$outdir$sample'_significant-in-'$test'.eps'

        qsub -e $err -o $out Scripts/Sub/weblogo.sh $input $output $bg_comp

        sleep 10s

    done

done
