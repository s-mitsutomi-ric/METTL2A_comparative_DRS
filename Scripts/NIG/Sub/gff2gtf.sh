#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N gff2gtf

gff=$1
gtf=${gff/.gff/.gtf}

agat_image='/usr/local/biotools/a/agat:1.1.0--pl5321hdfd78af_0'

singularity exec $agat_image agat_convert_sp_gff2gtf.pl --gff $gff -o $gtf
