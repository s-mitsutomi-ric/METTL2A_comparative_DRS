#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l epyc
#$ -l s_vmem=4G -l mem_req=4G
#$ -N nanopolish_index

sample=$1

concatenated_fastq='Longread_ConcatenatedFastq/'$sample'.fastq'
raw_dir='Rawdata/Nanopore_directRNAseq/'$sample'/fast5_pass/'

sing_image='/usr/local/biotools/n/nanopolish:0.14.0--hd7c1219_0'

singularity exec $sing_image nanopolish index \
    -d $raw_dir $concatenated_fastq
