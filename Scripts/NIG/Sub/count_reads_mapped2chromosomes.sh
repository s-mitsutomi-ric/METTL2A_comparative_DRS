#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N count_reads_mapped

bam=$1
outdir=$2

mkdir -p $outdir
out=$outdir$(basename $bam .bam)'.txt'

seqkit_image='/usr/local/biotools/s/seqkit:2.4.0--h9ee0642_0'

singularity exec $seqkit_image seqkit bam -C $bam &> $out
