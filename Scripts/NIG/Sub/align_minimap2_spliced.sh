#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N minimap2_spliced

sample=$1

ref="/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa"
#ref_indexed=$ref'.fai'

indir="Guppy_Results/"$sample"/pass/"
outdir="Alignment/Minimap2/Spliced/"
mkdir -p $outdir

sam=$outdir$sample".sam"
bam=${sam/.sam/.bam}
bambai=$bam".bai"

# Minimap2 and convert to sorted bam
minimap2 -a -x splice -uf -k14 -t32 $ref ${indir}*.fastq | \
    singularity exec /usr/local/biotools/s/samtools:1.9--h10a08f8_12 samtools view -bh -  | \
    singularity exec /usr/local/biotools/s/samtools:1.9--h10a08f8_12 samtools sort -o $bam

# Index
singularity exec /usr/local/biotools/s/samtools:1.9--h10a08f8_12 samtools index $bam $bambai
