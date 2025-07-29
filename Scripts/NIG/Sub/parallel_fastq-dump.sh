#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N fasterq-dump

sra_acc=$1
dir=$2

sing_image='/usr/local/biotools/p/parallel-fastq-dump:0.6.7--pyhdfd78af_0'

cp /etc/resolv.conf /tmp/
singularity exec -B /tmp $sing_image parallel-fastq-dump \
    --sra-id $sra_acc --threads 16 --outdir $dir --split-files --gzip
