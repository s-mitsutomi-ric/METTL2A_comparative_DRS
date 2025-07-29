#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N 

test=$1

bed_a='Nanocompore/Espresso/Methylated_sites/siMETTL2A_G_sig_positions_in_'$test'.bed'
bed_b='Nanocompore/Espresso/Methylated_sites/siMETTL2A_I_sig_positions_in_'$test'.bed'

out='Nanocompore/Espresso/Methylated_sites/common_sig_positions_in_'$test'.bed'

bedtools_image='/usr/local/biotools/b/bedtools:2.31.0--hf5e1c6e_2'

singularity exec $bedtools_image bedtools intersect \
    -a $bed_a -b $bed_b -s
