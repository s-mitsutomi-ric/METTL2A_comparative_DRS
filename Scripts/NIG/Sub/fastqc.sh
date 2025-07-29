#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N fastqc

# Option parser

while getopts o: option; do

    case $option in 

        o)
            outdir=$OPTARG;;
        \?)
            exit 1
            ;;
    esac

done

shift $((OPTIND - 1))

fastq=$1

: ${outdir:='Fastqc/'}
mkdir -p $outdir

num_threads=6

# Fastqc

fastqc_image='/usr/local/biotools/f/fastqc:0.12.1--hdfd78af_0'

singularity exec $fastqc_image fastqc --nogroup -o $outdir -t $num_threads $fastq
