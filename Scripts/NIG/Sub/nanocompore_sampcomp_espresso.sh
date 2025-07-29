#!/bin/bash
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -l intel
#$ -l d_rt=504:00:00 -l s_rt=504:00:00
#$ -l s_vmem=168G -l mem_req=168G
#$ -N nanocompore_sampcomp

cond=$1

fasta='Espresso/Espresso_Q/sample_info_N2_R0_updated.fasta'
outdir='Nanocompore/Espresso/SampComp/'$cond'/'
min_coverage=10

num_threads=6

controls=$(Scripts/Sub/prepare_tsvlist4nanocompore_espresso.sh 'Cont_D')
KDsamples=$(Scripts/Sub/prepare_tsvlist4nanocompore_espresso.sh $cond)

sing_image='/usr/local/biotools/n/nanocompore:1.0.4--pyhdfd78af_0'

singularity exec $sing_image nanocompore sampcomp \
    -1 $controls -2 $KDsamples -f $fasta -o $outdir \
    -t $num_threads --min_coverage $min_coverage
