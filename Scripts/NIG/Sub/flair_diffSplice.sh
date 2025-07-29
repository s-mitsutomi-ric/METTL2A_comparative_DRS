#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N flair_diffSplice

condition=$1

bed='Flair/Flair_collapse.isoforms.bed'
matrix='Flair/Flair_quantify/flair_quantify.counts.tsv'
num_threads=10
outdir='Flair/Flair_diffSplice/'$condition'/'

sing_image='/usr/local/biotools/f/flair:1.7.0--pyhdfd78af_1'

singularity exec $sing_image flair diffSplice \
    -i $bed -q $matrix --out_dir $outdir \
    --test --conditionA 'siControl-D' --conditionB $condition \
    --threads $num_threads
