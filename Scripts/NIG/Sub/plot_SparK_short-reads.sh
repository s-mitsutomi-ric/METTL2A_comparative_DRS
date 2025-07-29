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
samples=$(echo $(ls Alignment/STAR/Espresso_AsPC1/*.bdg.gz))
labels=$(echo $samples | sed \
        -e 's/_N[0-9]\+_S[0-9]\+_L001_Aligned.sortedByCoord.out_CPM_size-1.bdg.gz//g' \
        -e 's/Alignment\/STAR\/Espresso_AsPC1\/221223_NovaSeq_SP_TruseqUD_l1_//g' \
        -e 's/00[0-9]\+_[A-Z][0-9]\+_Dr_Taniue_[0-9]_//g' \
        -e 's/No_//g')

# merged gtf is used in order to show gene name
gtf='Database/Custom/Espresso_plus_gencode.v43_with-tRNA/merged.gtf'

python $spark_path -pr $position -cf $samples -gl $labels \
    -gtf $gtf \
    -gs yes -o $outdir$outname 
    