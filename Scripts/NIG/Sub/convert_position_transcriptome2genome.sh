#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N transcriptome2genome

input=$1
ref=$2
output=$3

singularity exec /usr/local/biotools/r/r-base:4.2.1 Rscript \
    Scripts/Sub/convert_position_transcriptome2genome.R -i $input -r $ref -o $output
