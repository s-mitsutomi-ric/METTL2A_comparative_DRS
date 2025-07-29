#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N filter_significant_positions

nanocompore_result=$1

dir=$(dirname $nanocompore_result)

significant_in_KStest=$dir'/sig_positions_in_KS.tsv'
significant_in_GMMtest=$dir'/sig_positions_in_GMM.tsv'
significant_in_dwell=$dir'/sig_positions_in_dwell.tsv'
significant_in_intensity=$dir'/sig_positions_in_intensity.tsv'

awk -v OFS="\t" '(($8<0.05 || $9<0.05)) {print $4,$1-1,$1}' $nanocompore_result \
    > $significant_in_KStest

awk -v OFS="\t" '(($7<0.05)) {print $4,$1-1,$1}' $nanocompore_result \
    > $significant_in_GMMtest

awk -v OFS="\t" '(($8<0.05)) {print $4,$1-1,$1}' $nanocompore_result \
    > $significant_in_dwell

awk -v OFS="\t" '(($9<0.05)) {print $4,$1-1,$1}' $nanocompore_result \
    > $significant_in_intensity
