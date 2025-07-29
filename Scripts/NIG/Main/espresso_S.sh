#!/bin/bash
set -e 
set -u
set -o pipefail

dir='Espresso/'
mkdir -p $dir

# Prepare sample_info.tsv

tsv=$dir'sample_info.tsv'
cp /dev/null $tsv

for sam in $(ls Alignment/Minimap2/Spliced/*.sam); do 
    echo -n -e $sam"\t"$(basename $sam)"\n" >> $tsv
done

# Perform ESPRESSO_S

today=$(date "+%Y%m%d")
logdir='Log/Espresso/S/'$today'/'
mkdir -p $logdir

err=$logdir'Espresso_S.err'
out=$logdir'Espresso_S.out'

qsub_beta -e $err -o $out Scripts/Sub/espresso_S.sh
