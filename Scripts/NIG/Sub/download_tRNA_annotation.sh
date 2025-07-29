#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -l short
#$ -l mem_req=8G -l s_vmem=8G
#$ -N download_tRNA_annotation

dir='Database/'
url=''https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_43/gencode.v43.tRNAs.gtf.gz

wget -P $dir $url

gunzip $dir$(basename $url)
