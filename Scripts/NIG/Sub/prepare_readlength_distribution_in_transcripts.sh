#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=128G -l mem_req=128G
#$ -N readlength_distribution

bed=$1
readlength=$2
output=$3

rscript='Scripts/Sub/prepare_readlength_distribution_in_transcripts.R'
r_image='/usr/local/biotools/r/r-base:4.2.1'

singularity exec $r_image Rscript $rscript -b $bed -o $output -r $readlength
