#!/bin/bash
#$ -S /bin/bash 
#$ -l s_vmem=16G -l mem_req=16G 
#$ -N nf-core_rnaseq
#$ -l intel

genome='/home/mitsutomi/Database/Gencode/GRCh38.p13.genome.fa'
transcriptome='/home/mitsutomi/Database/Gencode/gencode.v43.transcripts.fa'
gtf='/home/mitsutomi/Database/Gencode/gencode.v43.annotation.gtf'
samplesheet='Tables/samplesheet.csv'
outdir='RNA-seq_nf-core'
param_file='nextflow.config'
repo='nf-core/rnaseq'
rsem_index='/home/mitsutomi/Database/Gencode/RSEM-STAR-index.GRCh38.p13.gencode.v43/'
email='shuheimitsutomi@gmail.com'

./nextflow run $repo -profile uge \
     --input $samplesheet  \
     --outdir $outdir  \
     --star_index $rsem_index \
     --rsem_index $rsem_index \
     --fasta $genome --gtf $gtf --transcript_fasta $transcriptome --gencode \
     --max_memory 64GB --max_time 1.h -c $param_file \
     --email $email
