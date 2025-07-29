#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=40G -l mem_req=40G
#$ -N map_STAR

sing_image='/usr/local/biotools/s/star:2.7.10a--h9ee0642_0'

sample=$1
indir=$2
r1_suffix=$3
r2_suffix=$4
outdir=$5

read1=$indir$sample$r1_suffix
read2=$indir$sample$r2_suffix

index='/home/mitsutomi/Database/Gencode/RSEM-STAR-index.GRCh38.p13.gencode.v43/'

mkdir -p $outdir
prefix=$outdir$sample'_'

num_thread=8
min_chim_segment=10

singularity exec $sing_image STAR \
    --genomeDir $index \
    --readFilesIn $read1 $read2 \
    --runThreadN $num_thread \
    --outSAMtype BAM SortedByCoordinate \
    --outFileNamePrefix $prefix \
    --readFilesCommand zcat \
    --chimSegmentMin $min_chim_segment \
    --outSAMunmapped Within KeepPairs \
    --quantMode GeneCounts
