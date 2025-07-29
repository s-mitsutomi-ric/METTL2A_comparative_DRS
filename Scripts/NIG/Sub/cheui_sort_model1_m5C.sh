#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=4G -l mem_req=4G
#$ -N sort_cheui_model1

inputgz=$1
outgz=${inputgz/.tsv.gz/_sorted.tsv.gz}

zcat $inputgz | sort -k1  --parallel=15 | gzip -c > ${outgz} 
