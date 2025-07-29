#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l epyc
#$ -l s_vmem=64G -l mem_req=64G
#$ -l d_rt=24:00:00 -l s_rt=24:00:00
#$ -N sortmerna

input=$1
outdir=$2

basepath=$(basename $input .fastq.gz)

outdir='HAC-seq/Sortmerna/'
rRNA_out=$outdir$basepath'_rRNA_reads'
nonrRNA_out=$outdir$basepath'_non-rRNA_reads'
num_thread=8
w_dir='/home/mitsutomi/Sortmerna/run/'$basepath'/'

sing_image='/usr/local/biotools/s/sortmerna:4.3.6--h9ee0642_0'

singularity exec $sing_image sortmerna \
    --ref /home/mitsutomi/Database/rRNA-databases/rfam-5.8s-database-id98.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/rfam-5s-database-id98.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/silva-arc-16s-id95.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/silva-arc-23s-id98.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/silva-bac-16s-id90.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/silva-bac-23s-id98.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/silva-euk-18s-id95.fasta \
    --ref /home/mitsutomi/Database/rRNA-databases/silva-euk-28s-id98.fasta \
    --reads $input  \
    --workdir $w_dir \
    --threads $num_thread \
    --fastx --aligned $rRNA_out --other $nonrRNA_out 
