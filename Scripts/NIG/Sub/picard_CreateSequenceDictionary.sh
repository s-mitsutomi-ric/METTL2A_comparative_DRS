#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N picard_CreateSequenceDictionary

ref=$1

conda activate picard

picard CreateSequenceDictionary -R ${ref} 

conda deactivate 
