#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N split_bed

bed=$1
prefix=$2
suffix_length=$3

split -l 1 -d -a $suffix_length $bed $prefix
