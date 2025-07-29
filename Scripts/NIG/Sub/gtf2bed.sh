#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N gtf2bed

gtf=$1
bed=${gtf/.gtf/.bed}

agat_image='/usr/local/biotools/a/agat:1.1.0--pl5321hdfd78af_0'

singularity exec $agat_image agat_convert_sp_gff2bed.pl \
    --gff $gtf -o $bed
