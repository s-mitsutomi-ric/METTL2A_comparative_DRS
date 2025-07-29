#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -o Log/RSEM_quant.out -e Log/RSEM_quant.err
#$ -N RSEM_quant

sing_image='/usr/local/biotools/r/rsem:1.3.3--pl5321hecb563c_4'

input=$1
refname='/home/mitsutomi/Database/Gencode/RSEM-STAR-index.GRCh38.p13.gencode.v43'
sample_name=$(basename $input)

singularity exec $sing_image rsem-calculate-expression --alignments \
    --paired-end $input $refname $sample_name
