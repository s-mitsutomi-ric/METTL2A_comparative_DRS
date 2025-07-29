#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -m bea -M shuheimitsutomi@ric.u-tokyo.ac.jp
#$ -N espresso_Q

espresso_Q_path="$HOME/miniconda3/envs/espresso/bin/ESPRESSO_Q.pl"

gtf='/home/mitsutomi/Database/Gencode/gencode.v43.annotation.gtf'
list_samples='Espresso/sample_info.tsv.updated'

outdir='Espresso/Espresso_Q/'
mkdir -p $outdir

tsv_compt=$outdir'compatible_isoforms_each_read.tsv'

num_threads=5

conda activate espresso 

perl $espresso_Q_path -L $list_samples -A $gtf \
    -O $outdir -V $tsv_compt -T $num_threads

conda deactivate
