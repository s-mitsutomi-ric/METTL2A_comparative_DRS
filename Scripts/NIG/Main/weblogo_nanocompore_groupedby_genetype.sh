#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Weblogo/'$today'/'
mkdir -p $logdir

bg_comp='Nanocompore/Espresso/SampComp/siMETTL2A/all_sequences_composition.txt'

for file in $(ls Nanocompore/Espresso/Methylated_sites/*_in_*_*.fasta | grep -v 'merged'); do 

    echo $file
    file_basename=$(basename $file)

    err=${logdir}${file_basename}'.err'
    out=${logdir}${file_basename}'.out'

    input='Nanocompore/Espresso/Methylated_sites/'${file_basename}
    outdir='Weblogo/dRNA-seq_Nanocompore/'
    mkdir -p $outdir

    output=${outdir}${file_basename/.fasta/.eps}

    qsub -e $err -o $out Scripts/Sub/weblogo.sh $input $output $bg_comp

    sleep 5s

done
