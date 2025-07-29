#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=8G -l mem_req=8G
#$ -N filter_significant_positions

nanocompore_result=$1

dir=$(dirname $nanocompore_result)

# Fasta

significant_in_KStest=$dir'/sig_sequences_in_KS.fasta'
significant_in_GMMtest=$dir'/sig_sequences_in_GMM.fasta'
significant_in_dwell=$dir'/sig_sequences_in_dwell.fasta'
significant_in_intensity=$dir'/sig_sequences_in_intensity.fasta'

awk -v OFS="\t" '(($8<0.05 || $9<0.05)) {print ">"$4"|"$1"\n"$6}' $nanocompore_result \
    > $significant_in_KStest

awk -v OFS="\t" '(($7<0.05)) {print ">"$4"|"$1"\n"$6}' $nanocompore_result \
    > $significant_in_GMMtest

awk -v OFS="\t" '(($8<0.05)) {print ">"$4"|"$1"\n"$6}' $nanocompore_result \
    > $significant_in_dwell

awk -v OFS="\t" '(($9<0.05)) {print ">"$4"|"$1"\n"$6}' $nanocompore_result \
    > $significant_in_intensity

# Tsv

awk -v OFS="\t" '(($8<0.05 || $9<0.05)) {print $4"|"$1,$6}' $nanocompore_result \
    > ${significant_in_KStest/.fasta/.tsv}

awk -v OFS="\t" '(($7<0.05)) {print $4"|"$1,$6}' $nanocompore_result \
    > ${significant_in_GMMtest/.fasta/.tsv}

awk -v OFS="\t" '(($8<0.05)) {print $4"|"$1,$6}' $nanocompore_result \
    > ${significant_in_dwell/.fasta/.tsv}

awk -v OFS="\t" '(($9<0.05)) {print $4"|"$1,$6}' $nanocompore_result \
    > ${significant_in_intensity/.fasta/.tsv}
