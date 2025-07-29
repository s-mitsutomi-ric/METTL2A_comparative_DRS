#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N sort_bed

bed=$1
sorted=${bed/.bed/_sorted.bed}

bedtools_image='/usr/local/biotools/b/bedtools:2.31.0--hf5e1c6e_2'

singularity exec $bedtools_image bedtools sort -i $bed > $sorted
