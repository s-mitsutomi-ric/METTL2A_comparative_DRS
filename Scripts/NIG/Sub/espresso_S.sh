#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium 
#$ -l s_vmem=600G -l mem_req=600G
#$ -N espresso_S

espresso_S_path='/home/mitsutomi/miniconda3/envs/espresso/bin/ESPRESSO_S.pl'

ref='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
gtf='/home/mitsutomi/Database/Gencode/gencode.v43.annotation.gtf'
tsv='Espresso/sample_info.tsv'
outdir='Espresso/'

# To avoid filter out of chrM reads
chrM=''

num_threads=1

conda activate espresso 

perl $espresso_S_path -L $tsv -F $ref -A $gtf -O $outdir -M $chrM \
    --num_thread $num_threads

conda deactivate
