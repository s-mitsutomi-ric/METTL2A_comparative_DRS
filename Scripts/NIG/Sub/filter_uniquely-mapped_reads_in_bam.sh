#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N filter_uniq_reads

bam=$1
uniq_bam=${bam/.bam/_uniq.bam}

samtools_image='/usr/local/biotools/s/samtools:1.17--hd87286a_1'

singularity exec $samtools_image samtools view -q 4 $bam > $uniq_bam
