#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l intel
#$ -l s_vmem=16G -l mem_req=16G
#$ -N bed2fasta

bed=$1
fi=$2
fasta=$3

bedtools_image='/usr/local/biotools/b/bedtools:2.31.0--hf5e1c6e_2'

singularity exec $bedtools_image bedtools getfasta \
     -fi $fi -bed $bed -s -name > $fasta
