#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=192G -l mem_req=192G
#$ -N ribodetector

input=$1
length=$2
outdir=$3

basepath=$(basename $input .fastq.gz)

nonrRNA_output=$outdir$basepath'_nonrRNA.fastq.gz'
rRNA_output=$outdir$basepath'_rRNA.fastq.gz'

rd_image='/usr/local/biotools/r/ribodetector:0.2.7--pyhdfd78af_0'

singularity exec $rd_image ribodetector_cpu -t 15 \
    -l $length -i $input -e rrna \
    --chunk_size 4096 -o $nonrRNA_output -r $rRNA_output
