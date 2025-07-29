#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N bam2bg

bam=$1

deeptools_image='/usr/local/biotools/d/deeptools:3.5.2--pyhdfd78af_1'

bedgraph=${bam/.bam/}'_CPM_size1.bdg'

singularity exec $deeptools_image bamCoverage \
    -b $bam -o $bedgraph -of bedgraph \
    --normalizeUsing 'CPM' \
    --binSize 1 -p 'max'
