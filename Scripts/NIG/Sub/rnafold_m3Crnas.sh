#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=4G -l mem_req=4G
#$ -N RNAfold

vienna_rna_image='/usr/local/biotools/v/viennarna:2.6.4--py39pl5321h4e691d4_1'

input_fasta=$1

outdir='RNAfold/m3Crnas/'
mkdir -p $outdir
cd $outdir

singularity exec ${vienna_rna_image} RNAfold -p --MEA -i $input_fasta -o
