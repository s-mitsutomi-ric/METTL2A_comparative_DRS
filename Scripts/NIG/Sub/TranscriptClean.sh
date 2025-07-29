#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N TranscriptClean

sam=$1

genome='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
num_threads=1

outprefix='TranscriptClean/'
mkdir -p $outprefix


TranscriptClean_path='/home/mitsutomi/Softwares/TranscriptClean/TranscriptClean.py'

conda activate TranscriptClean

python $TranscriptClean_path  -s $sam -g $genome -o $outprefix -t $num_threads

conda deactivate
