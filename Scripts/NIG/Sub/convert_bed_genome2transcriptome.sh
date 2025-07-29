#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N convert_bed_genome2transcriptome

R_image='/usr/local/biotools/r/r-base:4.2.1'
script='Scripts/Sub/convert_bed_genome2transcriptome.R'

inbed=$1
outbed=${inbed/.bed/_transcriptome.bed}

singularity exec $R_image Rscript $script -i $inbed -o $outbed
