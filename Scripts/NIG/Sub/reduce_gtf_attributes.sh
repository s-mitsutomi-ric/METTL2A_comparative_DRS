#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N reduce_gtf_attributes

gtf=$1
out=${gtf/.gtf/_selected-attributes.gtf}

R_image='/usr/local/biotools/r/r-base:4.2.1'
script='Scripts/Sub/reduce_gtf_attributes.R'

singularity exec $R_image Rscript $script -i $gtf -o $out
