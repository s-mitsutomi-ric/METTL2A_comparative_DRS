#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l epyc
#$ -l s_vmem=16G -l mem_req=16G
#$ -N preprocess_fastq

samplename=$1

fast5_basedir='Single_fast5/'${samplename}'/'
fastq_filenames='Rawdata/Nanopore_directRNAseq/'${samplename}'/1d_pass.fq'
num_processes=8

tombo_image='/home/mitsutomi/DockerImage/tombo.sif'

singularity exec ${tombo_image} tombo preprocess annotate_raw_with_fastqs \
    --fast5-basedir ${fast5_basedir} \
    --fastq-filenames ${fastq_filenames} \
    --processes ${num_processes} --overwrite
