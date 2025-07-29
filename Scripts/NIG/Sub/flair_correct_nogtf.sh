#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N flair_correct

query=$1
basepath=$(basename $query)

genome='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
short_read_bed='Flair/junctions_from_sam_junctions.bed'
gtf='/home/mitsutomi/Database/Gencode/gencode.v43.annotation.gtf'

outdir='Flair/Flair-correct-nogtf/'
mkdir -p $outdir
outprefix=$outdir${basepath/.bed/}

sing_image='/usr/local/biotools/f/flair:1.7.0--pyhdfd78af_1'

singularity exec $sing_image flair correct \
    -q $query -g $genome -j $short_read_bed \
    -o $outprefix --nvrna

