#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l gpu -l cuda=2
#$ -l s_vmem=64G -l mem_req=16G -pe def_slot 4
#$ -l d_rt=96:00:00 -l s_rt=96:00:00
#$ -N guppy

# flowcell and kit
flowcell="FLO-PRO002"
kit="SQK-RNA002"

# Loop files
for sample_name in $(cat nanopore_samples.list); do 
     
    # path to fast5 directory
    input_dir="/home/mitsutomi/METTL2A/Rawdata/Nanopore_directRNAseq/$sample_name/fast5_pass/"

    # path to fastq directory
    results_dir="/home/mitsutomi/METTL2A/Guppy_Results/"
    output_dir=$results_dir$sample_name"/"

    # perform basecall using guppy
    guppy_basecaller \
    --input_path $input_dir \
    --save_path $output_dir \
    --num_callers 4 \
    --device 'cuda:0,1:4G' \
    --flowcell $flowcell \
    --kit $kit

done
