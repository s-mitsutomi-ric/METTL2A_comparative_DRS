#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N add_gene_record

input=$1
output=${input/.gtf/_geneplus.gtf}

r_image='/usr/local/biotools/r/r-base:4.2.1'
rscript='Scripts/Sub/add_gene_record_to_gtf.R'

singularity exec $r_image Rscript $rscript -i $input -o $output
