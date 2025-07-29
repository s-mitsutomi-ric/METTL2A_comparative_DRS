#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N fastp

input=$1
outdir=$2

basepath=$(basename $input .fastq.gz)
mkdir -p $outdir

out=$outdir$basepath'_processed.fastq.gz'
html_report=$outdir$basepath'_fastp.html'
json_report=$outdir$basepath'_fastp.json'

num_thread=16

sing_image='/usr/local/biotools/f/fastp:0.23.2--hb7a2d85_2'

singularity exec $sing_image fastp \
    -i $input -o $out \
    -h $html_report -j $json_report -w $num_thread
