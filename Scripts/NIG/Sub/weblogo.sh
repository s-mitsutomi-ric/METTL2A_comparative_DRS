#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N weblogo

fasta=$1
eps=$2
bg_comp=$3

weblogo_image='/usr/local/biotools/w/weblogo:3.7.9--pyhdfd78af_0'

singularity exec $weblogo_image weblogo --composition "$(cat $bg_comp)" < $fasta > $eps
