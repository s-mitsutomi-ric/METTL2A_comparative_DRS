#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N unique_read

inbam=$1
outbam=${inbam/.bam/_uniq.bam}

samtools_image='/usr/local/biotools/s/samtools:1.17--hd87286a_1'

singularity exec $samtools_image samtools view -h -q 4 $inbam > $outbam
