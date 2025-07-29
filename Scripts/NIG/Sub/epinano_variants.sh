#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N epinano_variants

sample=$1

conda activate epinano1.2

epinano_path='/home/mitsutomi/Softwares/EpiNano_1.2/Epinano_Variants.py'

ref='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'
bamdir='Alignment/Minimap2/Espresso_unspliced/'
bam=${bamdir}${sample}'.bam'
sam2tsv_path='/home/mitsutomi/miniconda3/envs/epinano1.2/bin/sam2tsv'
num_cpus=1

python3 ${epinano_path} \
    -R ${ref} -b ${bam} -s ${sam2tsv_path} -n $num_cpus -T 't'

conda deactivate
