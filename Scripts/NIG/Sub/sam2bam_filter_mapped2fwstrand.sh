#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -N sam2bam_filter
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G

sam=$1
bam=${sam/.sam/.bam}
bambai=$bam".bai"
ref_indexed='/home/mitsutomi/Database/Gencode/gencode.v43.transcripts.fa.fai'

# Convert to BAM and keep only primary alignments mapped on the forward strand
singularity exec /usr/local/biotools/s/samtools:1.9--h10a08f8_12 samtools view $sam -bh -t $ref_indexed -F 2324 | \
    singularity exec /usr/local/biotools/s/samtools:1.9--h10a08f8_12 samtools sort -o $bam

# Index
singularity exec /usr/local/biotools/s/samtools:1.9--h10a08f8_12 samtools index $bam $bambai
