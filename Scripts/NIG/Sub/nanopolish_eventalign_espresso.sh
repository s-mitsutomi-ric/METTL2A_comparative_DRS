#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l gpu
#$ -l s_vmem=80G -l mem_req=80G
#$ -N nanocompore_eventalign

sample=$1

reads_dir='Longread_ConcatenatedFastq/'
reads=$reads_dir$sample'.fastq'

bamdir='Alignment/Minimap2/Espresso_unspliced/'
bam=$bamdir$sample'.bam'
transcriptome_fasta='Espresso/Espresso_Q/sample_info_N2_R0_updated.fasta'

outdir='Nanocompore/Espresso/Eventalign_collapse/'$sample'/'

# Nanopolish options

export HDF5_PLUGIN_PATH=/usr/local/hdf5/lib/plugin
nanopolish_image='/usr/local/biotools/n/nanopolish:0.14.0--hd7c1219_0'

np_threads=32

# Nanocompore options

nanocompore_image='/usr/local/biotools/n/nanocompore:1.0.4--pyhdfd78af_0'
nc_threads=18

# Nanopolish -> nanocompore 

singularity exec $nanopolish_image nanopolish eventalign \
    --reads $reads --bam $bam \
    --genome $transcriptome_fasta --print-read-names \
    --scale-events --samples -t $np_threads | \
singularity exec $nanocompore_image nanocompore eventalign_collapse \
    -t $nc_threads --outpath $outdir --progress
