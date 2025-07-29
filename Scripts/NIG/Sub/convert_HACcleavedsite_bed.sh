#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N convert_HACcleavedsite_bed

inbedgz=$1
outbedgz=$2

python3 Scripts/Sub/convert_HACcleavedsite_bed.py -i $inbedgz -o $outbedgz
