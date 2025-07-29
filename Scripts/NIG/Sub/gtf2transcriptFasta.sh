#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -l d_rt=1:00:00 -l s_rt=1:00:00
#$ -N gtf2trfasta

gtf=$1

sing_image='/usr/local/biotools/g/gffread:0.12.7--hdcf5f25_3'

genome='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
transcript_fasta=${gtf/.gtf/.fasta}

singularity exec $sing_image gffread \
    -g $genome -w $transcript_fasta $gtf
