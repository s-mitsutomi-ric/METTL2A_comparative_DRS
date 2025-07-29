#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l epyc
#$ -l s_vmem=8G -l mem_req=8G
#$ -N nanopolish_eventalign

sample=$1

reads_dir='Longread_ConcatenatedFastq/'
reads=$reads_dir$sample'.fastq'

bamdir='Alignment/Minimap2/Unspliced/'
bam=$bamdir$sample'.bam'
transcriptome_fasta='/home/mitsutomi/Database/Gencode/gencode.v43.transcripts.fa'

outdir='Nanopolish/Eventalign/Reads/'
mkdir -p $outdir
out=$outdir$sample'.tsv'

num_threads=32

export HDF5_PLUGIN_PATH=/usr/local/hdf5/lib/plugin
sing_image='/usr/local/biotools/n/nanopolish:0.14.0--hd7c1219_0'

singularity exec $sing_image nanopolish eventalign \
    --reads $reads --bam $bam \
    --genome $transcriptome_fasta --print-read-names \
    --scale-events --samples -t $num_threads > $out
