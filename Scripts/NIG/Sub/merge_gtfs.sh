#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -N merge_gtfs
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G

ref=$1
addition=$2
out=$3

agat_image='/usr/local/biotools/a/agat:1.1.0--pl5321hdfd78af_0'

singularity exec $agat_image agat_sp_complement_annotations.pl \
    --ref $ref --add $addition --out $out
