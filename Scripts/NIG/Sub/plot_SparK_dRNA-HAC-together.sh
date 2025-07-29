#!/bin/bash

position=$1
outname=$2
outdir=$3
mkdir -p $outdir

spark_path='/home/mitsutomi/Softwares/SparK/SparK.py'
samples=$(echo $(ls HAC-seq/STAR_non-rRNA/*bedGraph.gz))
labels=$(echo $samples | sed -e 's/_Homo_sapiens_ncRNA-Seq_processed_nonrRNA_Aligned.sortedByCoord.out.bedGraph.gz//g' -e 's/HAC-seq\/STAR_non-rRNA\/SRR1261193[0-9]_GSM47732[23][0-9]_//g')
gtf='Database/Custom/Espresso_plus_gencode.v43/merged.gtf'
bed=$(echo $(ls Nanocompore/Espresso/Methylated_sites/siMETTL2A_sig_positions_in_*.bed))
bedlabel=$(echo $bed | sed 's/Nanocompore\/Espresso\/Methylated_sites\/siMETTL2A_//g')

python3 $spark_path -pr $position -cf $samples -gtf $gtf \
    -gl $labels -gs yes -o $outdir$outname -bed $bed -bedlab $bedlabel
