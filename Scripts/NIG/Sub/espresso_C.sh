#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l medium
#$ -l s_vmem=192G -l mem_req=192G
#$ -N espresso_C

target_id=$1

espresso_C_path='/home/mitsutomi/miniconda3/envs/espresso/bin/ESPRESSO_C.pl'

ref='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
indir='Espresso/' 

num_threads=20

conda activate espresso 

perl $espresso_C_path -I $indir -F $ref -X $target_id --num_thread $num_threads

conda deactivate
