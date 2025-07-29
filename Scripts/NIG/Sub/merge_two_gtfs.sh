#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N merge_two_gtfs

ref=$1
add=$2
output=$3

r_image='/usr/local/biotools/r/r-base:4.2.1'
rscript='Scripts/Sub/merge_two_gtfs.R'

singularity exec $r_image Rscript $rscript -r $ref -a $add -o $output
