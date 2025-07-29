#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N featureCounts_gene

outdir='FeatureCounts/Short-reads/'
mkdir -p $outdir

gtf='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_geneplus.gtf'

num_thread=32

# featureCounts
conda activate subread

output=$outdir'featureCounts_gene.txt'
featureCounts -B -p -t exon -g gene_id -a $gtf \
    -o $output -T $num_thread Alignment/STAR/Espresso_AsPC1/*_Aligned.sortedByCoord.out.bam

conda deactivate
