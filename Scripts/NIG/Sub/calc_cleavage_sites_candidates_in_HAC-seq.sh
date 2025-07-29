#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=128G -l mem_req=128G
#$ -N calc_cutsites

input=$1

outdir='HAC-seq/Cleavage_sites/'
mkdir -p $outdir

outtsv=$outdir$(basename $input .bed)'.tsv'
ref='Database/gencode.v43.annotation_plus-tRNA.bed'

rscript='Scripts/Sub/calc_cleavage_sites_candidates_in_HAC-seq.R'
r_image='/usr/local/biotools/r/r-base:4.2.1'

singularity exec $r_image Rscript $rscript -i $input -o $outtsv -r $ref
