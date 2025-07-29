#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N tombo_resquiggle

samplename=$1

fast5_basedir='Single_fast5/'${samplename}'/'
ref='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts.fasta'
num_processes=4
tombo_image='/home/mitsutomi/DockerImage/tombo.sif'

singularity exec ${tombo_image} tombo resquiggle --rna \
    --processes ${num_processes} \
    ${fast5_basedir} ${ref}
