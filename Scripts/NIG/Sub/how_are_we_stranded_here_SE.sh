#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l short
#$ -l s_vmem=32G -l mem_req=32G
#$ -N how_are_we_stranded_here

check_strandedness -g GTF [-fa TRANSCRIPTS] [-n NREADS] -r1 READS_1 -r2 READS_2 [-k KALLISTO_INDEX] [-p]
