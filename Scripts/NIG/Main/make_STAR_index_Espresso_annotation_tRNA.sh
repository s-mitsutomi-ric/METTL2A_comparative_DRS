#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/STAR/Index/'$today'/'
mkdir -p $logdir

genome='Database/GRCh38.p13.genome.fa'

# Make index for combined annotation

annotation='Database/Custom/Espresso_plus_gencode.v43_with-tRNA/merged.gtf'
index='Database/Custom/Espresso_plus_gencode.v43_with-tRNA/STAR_index'

err=$logdir'Espresso_gencode_tRNA.err'
out=$logdir'Espresso_gencode_tRNA.out'

qsub -e $err -o $out -v genome=$genome,annotation=$annotation,index=$index \
    Scripts/Sub/make_STAR_index.sh
