#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N trim_galore

basepath=$1
r1=$basepath'_R1_001.fastq.gz'
r2=$basepath'_R2_001.fastq.gz'
outdir="Trim_galore"

sing_image='/usr/local/biotools/t/trim-galore:0.6.7--hdfd78af_0'

singularity exec $sing_image trim_galore  \
    --cores 6 --gzip -o $outdir  \
    --paired $r1 $r2 
