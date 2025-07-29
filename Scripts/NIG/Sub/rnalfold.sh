#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=4G -l mem_req=4G
#$ -N RNALfold

vienna_rna_image='/usr/local/biotools/v/viennarna:2.6.4--py39pl5321h4e691d4_1'

input=$1
outdir=$2
mkdir -p $outdir

cd $outdir
singularity exec ${vienna_rna_image} RNALfold -i $input -o
