#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
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


# + strand
#  --filterRNAstrand=forward keeps minus-strand reads, which originally came from genes on the forward strand using a dUTP-based method
bedgraph=${bam/.bam/_plus.bedGraph}

singularity exec $deeptools_image bamCoverage \
    -b $bam -o $bedgraph -of bedgraph \
    --normalizeUsing $normalization \
    --filterRNAstrand reverse \
    --binSize $size -p 'max'

# - strand
bedgraph=${bam/.bam/_minus.bedGraph}

singularity exec $deeptools_image bamCoverage \
    -b $bam -o $bedgraph -of bedgraph \
    --normalizeUsing $normalization \
    --filterRNAstrand forward \
    --binSize $size -p 'max'
