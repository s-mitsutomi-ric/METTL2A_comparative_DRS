#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N flair_bam2bed12

bam=$1
basepath=$(basename $bam)
outdir='Flair/Uncorrected_bed12/'
mkdir -p $outdir

bed=$outdir${basepath/.bam/.bed}

sing_image='/usr/local/biotools/f/flair:1.7.0--pyhdfd78af_1'

singularity exec $sing_image bam2Bed12 -i $bam > $bed
