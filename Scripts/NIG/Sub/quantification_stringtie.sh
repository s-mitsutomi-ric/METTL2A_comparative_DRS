#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N stringtie

bam=$1
gtf=$2
outgtf=$3

stringtie_image='/usr/local/biotools/s/stringtie:2.2.1--hecb563c_2'
num_threads=8

singularity exec $stringtie_image stringtie \
     -e -B -p $num_threads -G $gtf -o $outgtf $bam
