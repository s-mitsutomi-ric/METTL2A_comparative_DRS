#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l intel
#$ -l s_vmem=8G -l mem_req=8G
#$ -N search_rownum

input=$1
output=${input/.tsv/_rownum_idx.tsv}

grep -n '#' $input | \
awk -v OFS="\t" '{print $0}' > $output
