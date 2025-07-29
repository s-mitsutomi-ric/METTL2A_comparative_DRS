#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N bam2bed12

bam=$1
bed12=${bam/.bam/.bed}

bedtools_image='/usr/local/biotools/b/bedtools:2.31.0--hf5e1c6e_2'

singularity exec $bedtools_image bedtools bamtobed -split -bed12 -i $bam > $bed12
