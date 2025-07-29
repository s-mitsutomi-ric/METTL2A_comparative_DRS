#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/AGAT/'$today'/'
mkdir -p $logdir

annotation='Database/Custom/gencode.v43_Espresso.AsPC1/gencode.v43_Espresso.AsPC1.gff'
attributes='gene_id,gene_name,transcript_id,transcript_name,exon_id'
outgff=${annotation/.gff/_limited-attributes.gff}
 
err=$logdir'reduce_annotation_attributes_gencode_Espresso.err'
out=${err/.err/.out}

qsub -e $err -o $out Scripts/Sub/reduce_annotation_attributes.sh \
    $annotation $attributes $outgff
