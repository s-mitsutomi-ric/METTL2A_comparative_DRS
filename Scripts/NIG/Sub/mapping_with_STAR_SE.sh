#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=64G -l mem_req=64G
#$ -N map_STAR

while getopts ior: option
do 
    case $option in 
        i)
            index=$OPTARG;;
        o)
            outdir=$OPTARG;;
        r)
            read=$OPTARG;;
        \?)
            exit 1
    esac
done

STAR_image='/usr/local/biotools/s/star:2.7.10a--h9ee0642_0'

mkdir -p $outdir
prefix=$outdir$(basename $read .fastq.gz)'_'

num_thread=8
min_chim_segment=10

# mapping with STAR

singularity exec $STAR_image STAR \
    --genomeDir $index \
    --readFilesIn $read \
    --runThreadN $num_thread \
    --outSAMtype BAM SortedByCoordinate \
    --outFileNamePrefix $prefix \
    --readFilesCommand zcat \
    --chimSegmentMin $min_chim_segment \
    --outSAMunmapped Within KeepPairs \
    --quantMode TranscriptomeSAM

# Index
bam=$prefix'Aligned.sortedByCoord.out.bam'
bambai=$bam'.bai'
samtools_image='/usr/local/biotools/s/samtools:1.16.1--h6899075_1'

singularity exec $samtools_image samtools index $bam $bambai
