#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=4G -l mem_req=4G
#$ -N summarise_rnafold

output='RNAfold/m3Crnas/summary.tsv'

# initialize output
echo -n "" > $output

for file in RNAfold/m3Crnas/*.fold
do
    awk 'NR==1{sub(/^>/,""); printf $0"\t"} NR==3{sub(/ .*/,""); printf $0"\t"} NR==4{sub(/ .*/,""); print $0}' "$file" >> $output
done
