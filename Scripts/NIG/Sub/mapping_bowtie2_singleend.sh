#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N bowtie2_single

fastq=$1
bowtie2_index=$2
outbam=$3

bowtie2_image='/usr/local/biotools/b/bowtie2:2.5.3--py39h6fed5c7_1'
samtools_image='/usr/local/biotools/s/samtools:1.16.1--h6899075_1'

singularity exec ${bowtie2_image} bowtie2 \
     -x ${bowtie2_index} -U ${fastq} | \
singularity exec ${samtools_image} samtools view -bS - | \
singularity exec ${samtools_image} samtools sort > ${outbam}

singularity exec ${samtools_image} samtools index ${outbam}
