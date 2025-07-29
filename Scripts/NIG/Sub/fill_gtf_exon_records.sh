#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N fill_exon_records_gtf

r_image='/usr/local/biotools/r/r-base:4.2.1'
rscript='Scripts/Sub/fill_gtf_exon_records.R'

input=$1
output=${input/.gtf/_exon-complemented.gtf}

singularity exec $r_image Rscript $rscript -i $input -o $output
