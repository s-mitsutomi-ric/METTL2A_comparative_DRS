#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N index

bam=$1
sorted=${bam/.bam/_sorted.bam}
bambai=$sorted'.bai'

samtools_image='/usr/local/biotools/s/samtools:1.16.1--h6899075_1'

singularity exec $samtools_image samtools sort $bam > $sorted
singularity exec $samtools_image samtools index $sorted $bambai
