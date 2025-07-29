#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N bowtie2_build

ref=$1
index=$2

bowtie2_image='/usr/local/biotools/b/bowtie2:2.5.3--py39h6fed5c7_1'

singularity exec ${bowtie2_image} bowtie2-build \
    $ref $index 
