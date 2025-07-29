#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N readlength_distribution

input=$1

outdir='HAC-seq/Read_length/'
mkdir -p $outdir

output=$outdir$(basename $input .bed)'.tsv'

ref='Database/gencode.v43.annotation_plus-tRNA.tsv'

rscript='Scripts/Sub/prepare_readlength_distribution_each_transcript.R'
r_image='/usr/local/biotools/r/r-base:4.2.1'

singularity exec $r_image Rscript $rscript -i $input -o $output -r $ref
