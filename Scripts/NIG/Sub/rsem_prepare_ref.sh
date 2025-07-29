#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N rsem_prepare_ref

while getopts i:g:r: option; do

    case $option in

        i)
            index=$OPTARG;;
        g)
            gtf=$OPTARG;;
        r)
            ref=$OPTARG;;
        \?)
            exit 1
            ;;

    esac

done

rsem_image='/usr/local/biotools/r/rsem:1.3.3--pl5321hecb563c_4'

singularity exec $rsem_image rsem-prepare-reference \
    --gtf $gtf -p 8 $ref $index
