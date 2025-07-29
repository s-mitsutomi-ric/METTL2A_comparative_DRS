#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N fastp

in1=$1
in2=$2
outprefix=$3

out1=$outprefix'_R1_processed.fastq.gz'
out2=$outprefix'_R2_processed.fastq.gz'
html_report=$outprefix'_fastp.html'
json_report=$outprefix'_fastp.json'

num_thread=16

fastp_image='/usr/local/biotools/f/fastp:0.23.2--hb7a2d85_2'

singularity exec $fastp_image fastp \
    -i $in1 -I $in2 -o $out1 -O $out2 \
    -h $html_report -j $json_report -w $num_thread
