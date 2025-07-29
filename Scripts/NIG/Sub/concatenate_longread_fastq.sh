#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=4G -l mem_req=4G
#$ -N concatenate_fastq

sample=$1

outdir='Longread_ConcatenatedFastq/'
mkdir -p $outdir
out=$outdir$sample'.fastq'

cat "Guppy_Results/$sample/pass/"*.fastq > $out

