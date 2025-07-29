#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -e Log/Isoquant/20230427_concatenate_isoquant_gtf.err
#$ -o Log/Isoquant/20230427_concatenate_isoquant_gtf.out
#$ -N concatenate_isoquant_gtf

cat Isoquant/*/*.extended_annotation.gtf | sort -u > 'Isoquant/extended_annotation.gtf'
