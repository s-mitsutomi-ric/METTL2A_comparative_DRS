#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=40G -l mem_req=40G
#$ -N map_STAR

read1=$1
read2=$2

while getopts io: option
do 
    case $option in 
        i)
            index=$OPTARG;;
        o)
            outprefix=$OPTARG;;
        \?)
            exit 1
    esac
done

sing_image='/usr/local/biotools/s/star:2.7.10a--h9ee0642_0'

num_thread=8
min_chim_segment=10

# Mapping

singularity exec $sing_image STAR \
    --genomeDir $index \
    --readFilesIn $read1 $read2 \
    --runThreadN $num_thread \
    --outSAMtype BAM SortedByCoordinate \
    --outFileNamePrefix $outprefix \
    --readFilesCommand zcat \
    --chimSegmentMin $min_chim_segment \
    --outSAMunmapped Within KeepPairs \
    --quantMode TranscriptomeSAM

# Index (genome mapping)
bam=$outprefix'Aligned.sortedByCoord.out.bam'
bambai=$bam'.bai'
samtools_image='/usr/local/biotools/s/samtools:1.16.1--h6899075_1'

singularity exec $samtools_image samtools index $bam $bambai
