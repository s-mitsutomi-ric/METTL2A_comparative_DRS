#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N sra_download

sra_acc=$1
dir='SRA_download/'

sra_tools_img='/usr/local/biotools/s/sra-tools:3.0.5--h9f5acd7_1'

singularity exec $sra_tools_img prefetch $sra_acc -O $dir
