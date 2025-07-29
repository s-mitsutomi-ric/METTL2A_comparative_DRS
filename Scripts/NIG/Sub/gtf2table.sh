#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N gtf2table

gtf=$1
table=${gtf/.gtf/.tsv}

agat_image='/usr/local/biotools/a/agat:1.1.0--pl5321hdfd78af_0'

singularity exec $agat_image agat_convert_sp_gff2tsv.pl -gff $gtf -o $table
