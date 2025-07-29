#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l epyc
#$ -l s_vmem=8G -l mem_req=8G
#$ -l d_rt=24:00:00 -l s_rt=24:00:00
#$ -N sortmerna

basepath=$1
indir='Trim_galore/'
r1=$indir$basepath'_R1_001_val_1.fq.gz'
r2=$indir$basepath'_R2_001_val_2.fq.gz'

outdir='Sortmerna/'
rRNA_out=$outdir$basepath'_rRNA_reads'
nonrRNA_out=$outdir$basepath'_non-rRNA_reads'
num_thread=16
memory=4000000
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
    --reads $r1 --reads $r2 \
    --workdir $w_dir \
    --threads $num_thread -m $memory \
    --fastx --aligned $rRNA_out --other $nonrRNA_out \
    --paired_in --out2
