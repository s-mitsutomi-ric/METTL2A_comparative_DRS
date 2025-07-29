#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l gpu
#$ -l s_vmem=72G -l mem_req=72G
#$ -N nanocompore_eventalign_collapse

sample=$1

indir='Nanopolish/Eventalign/Reads/'
eventalign_reads_tsv=$indir$sample'.tsv'

outdir='Nanocompore/Eventalign_collapse/'$sample'/'

num_threads=18

sing_image='/usr/local/biotools/n/nanocompore:1.0.4--pyhdfd78af_0'

singularity exec $sing_image nanocompore eventalign_collapse \
    -t $num_threads \
    -i ${eventalign_reads_tsv} --outpath ${outdir} --progress
