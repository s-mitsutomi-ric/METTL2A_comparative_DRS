#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N stringtie

gtflist=$1
refgtf=$2
merged_gtf=$3

stringtie_image='/usr/local/biotools/s/stringtie:2.2.1--hecb563c_2'
num_threads=8

singularity exec $stringtie_image stringtie --merge \
     -p $num_threads -G $refgtf -o $merged_gtf $gtflist
