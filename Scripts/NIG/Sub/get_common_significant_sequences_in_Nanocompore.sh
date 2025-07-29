#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=16G -l mem_req=16G
#$ -N get_common_seqs

test=$1
inputs='Nanocompore/Espresso/SampComp/siMETTL2A_'*'/sig_sequences_in_'$test'.tsv'

outdir='Nanocompore/Espresso/Methylated_sites/'
fasta=$outdir'common_sig_positions_in_'$test'.fasta'
tsv=$outdir'common_sig_positions_in_'$test'.tsv'

# fasta
cat $inputs | sort | uniq -c | awk '$1==2 {print ">"$2"\n"$3}' > $fasta

# tsv
cat $inputs | sort | uniq -c | awk -v OFS="\t" '$1==2 {print $2,$3}' > $tsv
