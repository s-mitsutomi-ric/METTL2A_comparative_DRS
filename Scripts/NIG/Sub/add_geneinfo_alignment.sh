#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N add_geneinfo_alignment

while getopts i:r:o:f: option
do
    case $option in
        i)
            input=$OPTARG;;
        r)
            ref=$OPTARG;;
        o)
            output=$OPTARG;;
        f)
            fraction=$OPTARG;;
    esac
done

bedtools_image='/usr/local/biotools/b/bedtools:2.31.0--hf5e1c6e_2'

singularity exec $bedtools_image bedtools intersect \
    -a $input -b $ref -loj -s -split -nobuf $fraction |
awk -v OFS="\t" '{print $1,$2,$3,$4"|"$16,$5,$6,$7,$8,$9,$10,$11,$12}' \
> $output
