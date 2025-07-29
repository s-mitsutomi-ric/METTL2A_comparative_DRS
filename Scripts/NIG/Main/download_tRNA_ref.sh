#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Download/'$today'/'
mkdir -p $logdir

dir='Database/'
url='https://raw.githubusercontent.com/rnabioinfor/TRAC-Seq/master/bowtie_index/hg38_tRNA.fa'

wget -P $dir $url
