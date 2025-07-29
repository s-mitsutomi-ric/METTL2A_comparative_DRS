#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=2G -l mem_req=2G
#$ -N filter_read_parameters
set -e
set -u
set -o pipefail

tsv=$1
transcript_id=$2
outtsv=$3

awk -v RS="#" -v ORS="\n" -v FS="\n" -v OFS="\n" -v tr_id=$transcript_id \
    '$1 ~ tr_id { for (i=3; i <= NF; i++) printf("%s%s", $(i), i<e ? OFS : "\n") }' $tsv \
    grep -v '^$' | cut -d $'\t' -f 1,2,5,9 > $outtsv
