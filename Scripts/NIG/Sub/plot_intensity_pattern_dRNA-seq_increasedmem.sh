#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=512G -l mem_req=512G
#$ -N plot_intensity_distribution

transcript_id=$1
figdir='Figures/Nanocompore/'
ref='Database/gencode.v43.annotation_transcript_id2name.tsv'

rscript='Scripts/Sub/plot_intensity_pattern_dRNA-seq.R'
r_image='/usr/local/biotools/r/r-base:4.2.1'

singularity exec $r_image Rscript $rscript -t $transcript_id -f $figdir -r $ref
