#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N bam2sam

bam=$1
sam=${bam/.bam/.sam}

sing_image_samtools='/usr/local/biotools/s/samtools:1.17--h00cdaf9_0'

singularity exec $sing_image_samtools samtools view -h $bam > $sam
