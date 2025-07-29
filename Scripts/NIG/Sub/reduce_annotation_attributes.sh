#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N reduce_attributes

annotation=$1
attributes=$2
outgff=$3

agat_image='/usr/local/biotools/a/agat:1.1.0--pl5321hdfd78af_0'

singularity exec $agat_image agat_sp_extract_attributes.pl \
     --gff $annotation --att $attributes -o $outgff --merge
