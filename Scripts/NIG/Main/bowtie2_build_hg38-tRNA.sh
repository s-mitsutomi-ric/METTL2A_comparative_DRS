#!/bin/bash
set -e
set -u
set -o pipefail

today=$(date "+%Y%m%d")
logdir='Log/Bowtie2/Build/'${today}'/'
mkdir -p $logdir

err=${logdir}'hg38_tRNA.err'
out=${err/.err/.out}

ref='Database/hg38_tRNA.fa'
mkdir -p ${ref}'_bowtie2/'
index=${ref}'_bowtie2/bowtie2'

qsub -e $err -o $out Scripts/Sub/bowtie2_build.sh \
    $ref $index
