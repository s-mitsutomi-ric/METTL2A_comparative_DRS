#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N bam2bdg

deeptools_image='/usr/local/biotools/d/deeptools:3.5.2--pyhdfd78af_1'

bam=$1
bedgraph=${bam/.bam/_bin1.bedGraph}

singularity exec $deeptools_image bamCoverage \
    -b $bam -o $bedgraph -of bedgraph \
    --binSize 1
