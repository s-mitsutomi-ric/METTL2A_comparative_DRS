#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N compress_bg

bedgraph=$1
compressed=$bedgraph'.gz'

samtools_image='/usr/local/biotools/s/samtools:1.17--hd87286a_1'

# bgzip
singularity exec $samtools_image bgzip -k $bedgraph

# tabix
singularity exec $samtools_image tabix -p bed $compressed
