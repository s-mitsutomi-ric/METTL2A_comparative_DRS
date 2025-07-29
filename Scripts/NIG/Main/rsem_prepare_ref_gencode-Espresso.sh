#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Rsem/Index/'$today'/'
mkdir -p $logdir

err=$logdir'gencode-espresso.err'
out=$logdir'gencode-espresso.out'

gtf='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gtf'
ref='Database/GRCh38.p13.genome.fa'
index='Database/Custom/gencode.v43_Espresso.AsPC1/RSEM_index'

qsub -e $err -o $out \
    -v gtf=$gtf,ref=$ref,index=$index Scripts/Sub/rsem_prepare_ref.sh
