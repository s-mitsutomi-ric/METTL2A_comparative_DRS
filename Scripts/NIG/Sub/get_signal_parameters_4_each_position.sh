#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=128G -l mem_req=128G
#$ -N get_signal_parameters

transcript_id=$1
outdir=$2

r_image='/usr/local/biotools/r/r-base:4.2.1'
rscript='Scripts/Sub/get_signal_parameters_4_each_position.R'

singularity exec $r_image Rscript $rscript -t $transcript_id -o $outdir
