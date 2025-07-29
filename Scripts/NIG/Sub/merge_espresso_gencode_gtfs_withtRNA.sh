#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -N merge_gtfs
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G

ref_gtf='Database/Custom/Espresso_plus_gencode.v43/merged.gtf'
tRNA_gtf='Database/gencode.v43.tRNAs.gtf'

gffread_image='/usr/local/biotools/g/gffread:0.12.7--hdcf5f25_3'

outdir='Database/Custom/Espresso_plus_gencode.v43_with-tRNA/'
mkdir -p $outdir

combined=$outdir'combined.gtf'
merged_gtf=$outdir'merged.gtf'
merged_gff=$outdir'merged.gff'

cat $ref_gtf $tRNA_gtf > $combined

singularity exec $gffread_image gffread -E $combined -F \
 --keep-genes --gene2exon --sort-alpha -T -o $merged_gtf
singularity exec $gffread_image gffread -E $combined -F \
 --keep-genes --gene2exon --sort-alpha -T -o $merged_gff

rm $combined
