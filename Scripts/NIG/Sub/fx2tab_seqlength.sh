#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N fx2tab

fasta=$1
output=$2

seqkit_image='/usr/local/biotools/s/seqkit:2.5.0--h9ee0642_0'

singularity exec $seqkit_image seqkit fx2tab $fasta -l -Q > $output
