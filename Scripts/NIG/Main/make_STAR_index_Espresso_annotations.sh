#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/STAR/Index/'$today'/'
mkdir -p $logdir

genome='Database/GRCh38.p13.genome.fa'

# Make index for AsPC-1 Espresso annotation

a1='Database/Custom/Espresso_AsPC1/Espresso_AsPC1_annotation_standardized.gtf'
i1='Database/Custom/Espresso_AsPC1/STAR_index'
e1=$logdir'Espresso_AsPC1.err'
o1=$logdir'Espresso_AsPC1.out'

qsub -e $e1 -o $o1 -v genome=$genome,annotation=$a1,index=$i1 \
    Scripts/Sub/make_STAR_index.sh

# Make index for combined annotation

a2='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gtf'
i2='Database/Custom/gencode.v43_Espresso.AsPC1/STAR_index'

e2=$logdir'Espresso_gencode.err'
o2=$logdir'Espresso_gencode.out'

qsub -e $e2 -o $o2 -v genome=$genome,annotation=$a2,index=$i2 \
    Scripts/Sub/make_STAR_index.sh
