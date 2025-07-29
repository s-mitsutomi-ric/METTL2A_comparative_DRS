#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N bed2bedgraph

bed=$1
genome=$2

bedgraph=${bed/.bed/.bedgraph}

bedtools_image='/usr/local/biotools/b/bedtools:2.31.0--hf5e1c6e_2'

sort -k 1,1 $bed | \
singularity exec $bedtools_image bedtools genomecov \
    -i - -bg -g $genome > $bedgraph
