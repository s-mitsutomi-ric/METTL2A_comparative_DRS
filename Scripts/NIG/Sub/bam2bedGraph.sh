#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N bam2bg

while getopts bns: option
do
    case $option in 
        b)
            bam=$OPTARG;;
        n)
            normalization=$OPTARG;;
        s)
            size=$OPTARG;;
        \?)
            exit 1;;
    esac
done

deeptools_image='/usr/local/biotools/d/deeptools:3.5.2--pyhdfd78af_1'

bedgraph=${bam/.bam/.bedGraph}

singularity exec $deeptools_image bamCoverage \
    -b $bam -o $bedgraph -of bedgraph \
    --normalizeUsing $normalization \
    --binSize $size -p 'max'
