#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N get_markov_bg

fasta=$1
bgfile=$2
order=$3

memechip_image='/usr/local/biotools/m/meme:5.5.5--pl5321hda358d9_0'

singularity exec ${memechip_image} fasta-get-markov \
    -m $order $fasta $bgfile
