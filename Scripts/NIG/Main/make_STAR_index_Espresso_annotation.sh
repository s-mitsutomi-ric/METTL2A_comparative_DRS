#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/STAR/Index/'$today'/'
mkdir -p $logdir

genome='Database/GRCh38.p13.genome.fa'

# Make index for AsPC-1 Espresso annotation

espresso_dir='Database/Custom/Espresso_AsPC1/'
mkdir -p $espresso_dir

a1=$espresso_dir'Espresso_AsPC1_annotation.gtf'
cp 'Espresso/Espresso_Q/sample_info_N2_R0_updated.gtf' $a1

i1=$espresso_dir'STAR_index'
e1=$logdir'Espresso_AsPC1.err'
o1=$logdir'Espresso_AsPC1.out'

qsub -e $e1 -o $o1 -v genome=$genome,annotation=$a1,index=$i1 \
    Scripts/Sub/make_STAR_index.sh

# Make index for combined annotation

a2='Database/Custom/Espresso_plus_gencode.v43/merged.gtf'
i2='Database/Custom/Espresso_plus_gencode.v43/STAR_index'

e2=$logdir'Espresso_gencode.err'
o2=$logdir'Espresso_gencode.out'

qsub -e $e2 -o $o2 -v genome=$genome,annotation=$a2,index=$i2 \
    Scripts/Sub/make_STAR_index.sh
