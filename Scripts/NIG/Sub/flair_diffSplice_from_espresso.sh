#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N flair_diffSplice

condition=$1

bed='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation.bed'
matrix='Espresso/Espresso_Q/sample_info_N2_R0_abundance_for_flairdiff.tsv'
num_threads=10
outdir='Espresso/Flair_diffSplice/'$condition'/'

sing_image='/usr/local/biotools/f/flair:1.7.0--pyhdfd78af_1'

singularity exec $sing_image flair diffSplice \
    -i $bed -q $matrix --out_dir $outdir \
    --test --conditionA 'Cont-D' --conditionB $condition \
    --threads $num_threads
