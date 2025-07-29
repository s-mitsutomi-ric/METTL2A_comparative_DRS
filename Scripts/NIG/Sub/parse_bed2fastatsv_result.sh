#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N parse_bed2fastatsv_result

R_image='/usr/local/biotools/r/r-base:4.2.1'
script='Scripts/Sub/parse_bed2fastatsv_result.R'

input=$1
output=$2

singularity exec $R_image Rscript $script -i $input -o $output
