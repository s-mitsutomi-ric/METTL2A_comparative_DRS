#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N sra_download

sra_acc=$1
outdir=$2

conda activate grabseqs

grabseqs sra -o $outdir -m metadata.csv -t 16 -r 3 $sra_acc

conda deactivate
