#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N calc_AlkAnilineSeq_cleavate_sites

R_image='/usr/local/biotools/r/r-base:4.2.1'
script='Scripts/Sub/calc_AlkAnilineSeq_cleavate_sites_in_bed.R'

inbed=$1
outbed=${inbed/.bed/_cleavage.bed}

singularity exec $R_image Rscript $script -i $inbed -o $outbed
