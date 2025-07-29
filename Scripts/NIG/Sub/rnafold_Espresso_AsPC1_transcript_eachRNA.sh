#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=4G -l mem_req=4G
#$ -N RNALfold

vienna_rna_image='/usr/local/biotools/v/viennarna:2.6.4--py39pl5321h4e691d4_1'

transcript_id=$1
outdir=$2
table_path='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.tsv'

grep $transcript_id $table_path | cut -f2 | RNAfold -p --MEA