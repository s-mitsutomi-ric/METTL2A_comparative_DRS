#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=8G -l mem_req=8G
#$ -l d_rt=2:00:00 -l s_rt=2:00:00
#$ -N samtools_faidx

fasta=$1
sing_image='/usr/local/biotools/s/samtools:1.9--h10a08f8_12'

singularity exec $sing_image samtools faidx $fasta
