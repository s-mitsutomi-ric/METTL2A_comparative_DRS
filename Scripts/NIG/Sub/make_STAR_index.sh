#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=64G -l mem_req=64G
#$ -l d_rt=24:00:00 -l s_rt=24:00:00 
#$ -N index_STAR

while getopts aig: option
do
    case $option in
        a)
            annotation=$OPTARG;;
        i)
            index=$OPTARG;;
        g)
            genome=$OPTARG;;
        \?)
            exit 1;;
    esac
done

th=16

STAR_image='/usr/local/biotools/s/star:2.7.10a--h9ee0642_0'

singularity exec $STAR_image STAR \
    --runMode genomeGenerate \
    --genomeDir $index \
    --sjdbGTFfile $annotation \
    --genomeFastaFiles $genome \
    --runThreadN $th 
