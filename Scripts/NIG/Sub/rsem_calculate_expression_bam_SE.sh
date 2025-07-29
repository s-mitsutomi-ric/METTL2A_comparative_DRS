#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N rsem-calculate-expression

while getopts b:i:p:s: option
do

    case $option in

        b)
            bam=$OPTARG;;
        i)
            index=$OPTARG;;
        p)
            prefix=$OPTARG;;
        s)
            strand=$OPTARG;;
        \?)
            exit 1
            ;;

    esac

done

num_threads=8

rsem_image='/usr/local/biotools/r/rsem:1.3.3--pl5321hecb563c_4'

singularity exec $rsem_image rsem-calculate-expression \
    --strandedness $strand -p $num_threads --alignments $bam $index $prefix
