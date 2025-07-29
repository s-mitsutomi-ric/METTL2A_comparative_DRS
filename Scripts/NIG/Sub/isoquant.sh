#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=128G -l mem_req=128G
#$ -N isoquant

bamlist="Lists/spliced_bams.list"

ref='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
gtf='/home/mitsutomi/Database/Gencode/gencode.v43.annotation.gtf'

outdir='Isoquant'
th=32

export OPENBLAS_NUM_THREADS=$th # to avoid error

singularity exec /usr/local/biotools/i/isoquant:3.2.0--hdfd78af_0 isoquant.py \
    --data_type nanopore --stranded forward \
    --bam_list $bamlist --reference $ref --genedb $gtf --complete_genedb \
    --output $outdir --report_novel_unspliced true --threads $th \
    --transcript_quantification with_inconsistent
