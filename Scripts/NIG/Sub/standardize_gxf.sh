#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N standardize_gtf

gxf=$1
out=${gxf/.g[tf]f/_standardized.gff}

agat_image='/usr/local/biotools/a/agat:1.1.0--pl5321hdfd78af_0'

singularity exec $agat_image agat_convert_sp_gxf2gxf.pl \
    -g $gxf -o $out
