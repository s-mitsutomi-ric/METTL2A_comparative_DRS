#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N plot_SparK

position=$1
outname=$2
outdir=$3
mkdir -p $outdir

spark_path='/home/mitsutomi/Softwares/SparK/SparK.py'
samples=$(echo $(ls -r Alignment/Minimap2/Spliced/*.bedGraph.gz))
labels=$(echo $samples | sed -e 's/_N[0-9].bedGraph.gz//g' -e 's/Alignment\/Minimap2\/Spliced\/[0-9]\+_DrTaniue_[0-9]_//g')
gtf='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gtf'

python $spark_path -pr $position -cf $samples -gl $labels \
    -gtf $gtf \
    -gs yes -o $outdir$outname -scale no 
