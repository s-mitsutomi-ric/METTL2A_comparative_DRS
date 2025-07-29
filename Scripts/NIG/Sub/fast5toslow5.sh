#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N fast5toslow5

fast5s=$1
outdir=$2

conda activate slow5tools

slow5tools fast5toslow5 -p 64 $fast5s -d $outdir

conda deactivate
