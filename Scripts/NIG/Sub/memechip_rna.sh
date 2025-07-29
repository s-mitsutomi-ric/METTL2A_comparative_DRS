#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N meme-chip

fasta=$1
outdir=$2
bg=$3

minw=5
maxw=10

memechip_image='/usr/local/biotools/m/meme:5.5.5--pl5321hda358d9_0'

bfile='Database/Custom/Espresso_AsPC1/Espresso_AsPC1.transcripts_markovbg_order_2.txt'

singularity exec ${memechip_image} meme-chip \
    -oc ${outdir} \
    -minw ${minw} -maxw ${maxw} \
    -bfile ${bg} \
    -rna \
    ${fasta}
