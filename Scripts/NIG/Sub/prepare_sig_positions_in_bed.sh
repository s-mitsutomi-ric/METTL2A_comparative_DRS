#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N sig_positions_bed

input=$1
bed=${input/.tsv/.bed}

awk -F '[|\t]' -v OFS="\t" '{print $1,1+$2,2+$2,$3}' $input > $bed 
