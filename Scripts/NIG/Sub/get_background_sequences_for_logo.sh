#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N get_background_sequences

sample=$1
dir='Nanocompore/Espresso/SampComp/'$sample'/'
nanocompore_result=$dir'outnanocompore_results.tsv'

all_sequences=$dir'all_sequences.fasta'

awk -v OFS="\t" '{print ">"$4"|"$1"\n"$6}' $nanocompore_result \
    > $all_sequences
