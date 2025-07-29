#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N fastp

input=$1
basepath=$(basename $input)

in1=$input'_R1_001.fastq.gz'
in2=$input'_R2_001.fastq.gz'

outdir='Fastp/'
mkdir -p $outdir

out1=$outdir$basepath'_R1_001_processed.fastq.gz'
out2=$outdir$basepath'_R2_001_processed.fastq.gz'
html_report=$outdir$basepath'_fastp.html'
json_report=$outdir$basepath'_fastp.json'

num_thread=16

sing_image='/usr/local/biotools/f/fastp:0.23.2--hb7a2d85_2'


singularity exec $sing_image fastp \
    -i $in1 -I $in2 -o $out1 -O $out2 \
    -h $html_report -j $json_report -w $num_thread
