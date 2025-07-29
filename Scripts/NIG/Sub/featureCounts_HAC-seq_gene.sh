#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N featureCounts_gene

outdir='HAC-seq/FeatureCounts/'
mkdir -p $outdir

gtf='Database/Custom/gencode.v43.plus.tRNA_Espresso.AsPC1/gencode.v43.plus.tRNA_Espresso.AsPC1.gtf'

num_thread=32

# featureCounts
conda activate subread

output=$outdir'featureCounts_gene.txt'
featureCounts -s1 -t exon -g gene_id -a $gtf \
    -o $output -T $num_thread HAC-seq/STAR/Fastp/*_processed_Aligned.sortedByCoord.out.bam

conda deactivate
