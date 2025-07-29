#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N rsem_validate

bam=$1

rsem_image='/usr/local/biotools/r/rsem:1.3.3--pl5321hecb563c_4'

singularity exec $rsem_image rsem-sam-validator $bam
 