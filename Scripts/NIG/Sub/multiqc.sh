#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N multiqc

sing_image='/usr/local/biotools/m/multiqc:1.13--pyhdfd78af_0'
dir=$1
cwd=$pwd

cd $dir
singularity exec $sing_image multiqc .
cd $cwd
