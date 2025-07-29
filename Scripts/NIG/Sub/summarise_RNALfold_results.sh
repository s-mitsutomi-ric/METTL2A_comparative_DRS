#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=4G -l mem_req=4G
#$ -N summarise_rnalfold

for file in RNALfold/*.lfold; do
    echo -e "$file\t$(tail -n 1 $file)"
done > RNALfold/summary.tsv
