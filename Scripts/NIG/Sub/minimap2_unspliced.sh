#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N minimap2_unspliced

sample=$1
transcriptome_fasta=$2
outdir=$3

#minimap2_image='/usr/local/biotools/m/minimap2:2.24--h7132678_1'
samtools_image='/usr/local/biotools/s/samtools:1.9--h10a08f8_12'

transcriptome_fasta_index=$transcriptome_fasta'.fai'
fastq_dir='Guppy_Results/'$sample'/pass/'

outdir='Alignment/Minimap2/Espresso_unspliced/'
mkdir -p $outdir

bam=$outdir$sample'.bam'
bambai=$bam'.bai'

num_threads=8

# mapping using minimap2 (unspliced mode)
# then convert to bam and sort
minimap2 -ax map-ont -t $num_threads $transcriptome_fasta ${fastq_dir}*.fastq | \
singularity exec $samtools_image samtools view -bh -t $transcriptome_fasta_index -F 2324 - | \
singularity exec $samtools_image samtools sort -o $bam

# index the bam
singularity exec $samtools_image samtools index $bam $bambai
