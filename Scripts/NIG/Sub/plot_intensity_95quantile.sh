#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=192G -l mem_req=192G
#$ -N plot_intensity_distribution

transcript_id=$1
figdir='Figures/Nanocompore/'
ref='Database/gencode.v43.annotation_transcript_id2name.tsv'

rscript='Scripts/Sub/plot_intensity_95quantile.R'

conda activate tidyverse

Rscript $rscript -t $transcript_id -f $figdir -r $ref

conda deactivate
